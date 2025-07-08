terraform {
  required_version = "1.5.7"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version              = "5.79.0"
      configuration_aliases = [ aws.aws-us-east-1 ]
    }
  }
}

#data for check the existence of declared allowed_internal_zones in the account
data "aws_route53_zone" "available_zones" {
  for_each     = toset(var.allowed_internal_zones)
  name         = "${each.key}."   # Append a trailing dot
  private_zone = false
}

locals {

  #check overlapping zone between internal and external
  overlap_zones = [ for z in var.allowed_internal_zones : z if contains(var.allowed_external_zones, z) ]

  #sort internal zones
  sanitized_zones = [ for z in var.allowed_internal_zones : trimsuffix(z, ".") ]
  sorted_zones = reverse([
    for key in sort([
      for zone in local.sanitized_zones : format("%03d.%s", length(split(zone, ".")), zone)
    ]) : replace(key, "/^[0-9]+\\./", "")
  ])

  #external zones sort
  sanitized_external_zones = [ for z in var.allowed_external_zones : trimsuffix(z, ".") ]
  sorted_external_zones = var.allowed_external_zones != [] ? reverse([
    for key in sort([
      for zone in local.sanitized_external_zones : format("%03d.%s", length(split(zone, ".")), zone)
    ]) : replace(key, "/^[0-9]+\\./", "")
  ]) : []

  normalized_domains = [ for d in var.domains : trimsuffix(d, ".") ]

  #internal candidate zone: match domain against internal zones
  internal_candidate_zone = {
    for domain in local.normalized_domains :
    domain =>
      contains(local.sanitized_zones, domain)
      ? domain
      : try(
          one([
            for zone in local.sorted_zones : zone if endswith(domain, ".${zone}")
          ]),
          null
        )
  }

  #external candidate zone: match domain against external zones
  external_candidate_zone = var.allowed_external_zones != [] ? {
    for domain in local.normalized_domains :
    domain =>
      try(
        one([
          for zone in local.sorted_external_zones : zone if ((domain == zone) || endswith(domain, ".${zone}"))
        ]),
        null
      )
  } : {}

  #final parent zone: if both candidates zone exist, choose the one with more labels (more specific)
  final_parent_zone = {
    for domain in local.normalized_domains :
    domain =>
      (
        local.internal_candidate_zone[domain] == null ? local.external_candidate_zone[domain]
        : local.external_candidate_zone[domain] == null ? local.internal_candidate_zone[domain]
        : (
            length(regexall("[^.]+", local.external_candidate_zone[domain])) > length(regexall("[^.]+", local.internal_candidate_zone[domain]))
            ? local.external_candidate_zone[domain]
            : local.internal_candidate_zone[domain]
          )
      )
  }

  internal_domains = { for domain, zone in local.final_parent_zone : domain => zone if zone != null && contains(local.sanitized_zones, zone) }
  external_domains = { for domain, zone in local.final_parent_zone : domain => zone if zone != null && contains(local.sanitized_external_zones, zone) }


  domains_without_match = [
    for d in local.normalized_domains :
    d if lookup(local.final_parent_zone, d, null) == null
  ]

  zone_ids = {
    for name, zone in data.aws_route53_zone.available_zones : trimsuffix(name, ".") => zone.zone_id
  }
}

resource "aws_acm_certificate" "main" {
  provider                  = aws.aws-us-east-1
  domain_name               = local.normalized_domains[0]
  subject_alternative_names = slice(local.normalized_domains, 1, length(local.normalized_domains))
  validation_method         = "DNS"
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true

    precondition {
      condition     = length(data.aws_route53_zone.available_zones) == length(var.allowed_internal_zones)
      error_message = "The following allowed_internal_zones were not found in AWS: ${join(", ", [ for zone in var.allowed_internal_zones : zone if !contains(keys(data.aws_route53_zone.available_zones), zone) ])}."
    }
    precondition {
      condition = length(local.overlap_zones) == 0
      error_message = "Internal and external zones must be different values: ${join(", ", local.overlap_zones)}."
    }
    precondition {
      condition     = length(local.domains_without_match) == 0
      error_message = "The following domains did not match any allowed_internal_zones or allowed_external_zones: ${join(", ", local.domains_without_match)}. Check domains, allowed_internal_zones, and allowed_external_zones."
    }
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options :
    trimsuffix(dvo.domain_name, ".") => dvo if contains(keys(local.internal_domains), trimsuffix(dvo.domain_name, "."))
  }

  allow_overwrite = true
  name            = each.value.resource_record_name
  type            = each.value.resource_record_type
  records         = [ each.value.resource_record_value ]
  ttl             = 60
  zone_id         = local.zone_ids[ local.final_parent_zone[trimsuffix(each.value.domain_name, ".")] ]
}

#auto certificate validation is executed only if there are no external domains
resource "aws_acm_certificate_validation" "main" {
  count = length(local.external_domains) == 0 ? 1 : 0

  provider                = aws.aws-us-east-1
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [ for record in aws_route53_record.validation : record.fqdn ]
}