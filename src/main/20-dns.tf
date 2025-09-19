  
data "aws_route53_zone" "base_domain_name" {
  name         = "${var.dns_zone}."
  private_zone = false
}

data "aws_route53_zone" "pagopa_domain_name" {
  count        = var.pagopa_zone_delegation_enabled ? 1 : 0
  name         = "${var.pagopa_dns_zone}."
  private_zone = false
}

provider "aws" {
  alias  = "aws-us-east-1"
  region = "us-east-1"
}

module "acm_api" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  for_each = var.api_domains

  providers = {
    aws = aws
  }

  wait_for_validation = true
  
  domain_name = "${each.key}.${var.dns_zone}"
  zone_id     = data.aws_route53_zone.base_domain_name.zone_id

  subject_alternative_names = []

  tags = {
    Name = "${each.key}.${var.dns_zone}"
  }
}

resource "aws_api_gateway_domain_name" "apigw_custom_domain" {
  for_each = var.apigw_custom_domains

  domain_name = "${each.key}.${var.dns_zone}"
  regional_certificate_arn = module.acm_api[each.key].acm_certificate_arn
  security_policy = "TLS_1_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "apigw_custom_domain_dns" {
  for_each = var.apigw_custom_domains

  name    = "${each.key}.${var.dns_zone}"
  type    = "A"
  zone_id     = data.aws_route53_zone.base_domain_name.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_api_gateway_domain_name.apigw_custom_domain[each.key].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.apigw_custom_domain[each.key].regional_zone_id
  }
}

resource "aws_route53_record" "caa_dns_entry" {
  name    = "${var.dns_zone}"
  type    = "CAA"
  ttl     = 120
  zone_id = data.aws_route53_zone.base_domain_name.zone_id

  records        = [
      "0 issue \"amazonaws.com\"",
      "0 issue \"letsencrypt.org\""
    ]
}

# Add DNS CNAMEs to refer external products website. 
# Example: add cname from assistenza.notifichedigitali.it to  hc-send.zendesk.com;
# used only in production environment 
resource "aws_route53_record" "cname_dns_entry" {
  for_each = jsondecode(var.pn_dns_extra_cname_entries)

  name    = each.key
  type    = "CNAME"
  ttl     = 300
  zone_id = data.aws_route53_zone.base_domain_name.zone_id

  records = [each.value]
}

resource "aws_route53_record" "pagopa_cname_dns_entry" {
  for_each = var.pagopa_zone_delegation_enabled ? jsondecode(var.pagopa_dns_extra_cname_entries) : {}
  name     = each.key
  type     = "CNAME"
  ttl      = 300
  zone_id  = data.aws_route53_zone.pagopa_domain_name[0].zone_id
  records  = [each.value]
}

resource "aws_route53_record" "pn_dns_records" {
  for_each = var.pn_dns_records

  zone_id = data.aws_route53_zone.base_domain_name.zone_id
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.value
}

module "acm_cdn" {
  source  = "terraform-aws-modules/acm/aws"
  version = "4.3.2"

  for_each = var.cdn_domains

  providers = {
    aws = aws.aws-us-east-1
  }

  wait_for_validation = true
  
  domain_name = "${each.key}.${var.dns_zone}"
  zone_id     = data.aws_route53_zone.base_domain_name.zone_id

  subject_alternative_names = []

  tags = {
    Name = "${each.key}.${var.dns_zone}"
  }
}

module "landing_cdn_multi_domain_acm_cert" {
  count = var.generate_landing_multi_domain_cdn_cert ? 1 : 0
  source = "./modules/cdn-multi-domain-acm-cert"
  providers = {
    aws.aws-us-east-1 = aws.aws-us-east-1
  }
  domains = var.landing_multi_domain_cert_domains
  allowed_internal_zones = var.landing_cdn_allowed_internal_zones
  allowed_external_zones = var.landing_cdn_allowed_external_zones
}