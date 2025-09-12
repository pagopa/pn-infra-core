resource "aws_route53_zone" "vpn" {
  for_each = var.vpc_pn_simulator_vpn_enabled ? { "enabled" = true } : {}

  name    = var.environment == "prod" ? "vpn.notifichedigitali.it" : format("vpn.%s.notifichedigitali.it", var.environment)
  comment = "Hosted zone per ACM e VPN"
}

resource "aws_acm_certificate" "vpn" {
  for_each = var.vpc_pn_simulator_vpn_enabled ? { "enabled" = true } : {}

  domain_name       = var.environment == "prod" ? "vpn.notifichedigitali.it" : format("vpn.%s.notifichedigitali.it", var.environment)
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "vpn" {

  for_each =  var.vpc_pn_simulator_vpn_enabled ? {
    for dvo in aws_acm_certificate.vpn["enabled"].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.vpn["enabled"].zone_id
}

resource "aws_acm_certificate_validation" "vpn" {
  for_each = var.vpc_pn_simulator_vpn_enabled ? { "enabled" = true } : {}

  certificate_arn         = aws_acm_certificate.vpn["enabled"].arn
  validation_record_fqdns = [for record in aws_route53_record.vpn : record.fqdn]
}

