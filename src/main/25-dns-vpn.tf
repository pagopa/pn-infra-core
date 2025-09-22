resource "aws_route53_zone" "vpn" {
  name    = format("vpn.%s", var.dns_zone)
  comment = "Hosted zone privata per VPN e routing ALB"
  vpc {
    vpc_id = module.vpc_pn_vpn["enabled"].vpc_id
  }
}

###########################################################
######          ACM Certificate for vpn.<>           ######
###########################################################
resource "aws_acm_certificate" "vpn" {
  domain_name       = format("vpn.%s", var.dns_zone)
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "vpn_cert_validation" {
  for_each = var.vpc_pn_vpn_is_enabled ? {
    for dvo in aws_acm_certificate.vpn.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  zone_id = data.aws_route53_zone.base_domain_name.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "vpn" {
  for_each = var.vpc_pn_vpn_is_enabled ? { "enabled" = true } : {}

  certificate_arn         = aws_acm_certificate.vpn.arn
  validation_record_fqdns = [for record in aws_route53_record.vpn_cert_validation : record.fqdn]
}

###########################################################
#####       simulator.vpn.<domain> → ALB internal     #####
###########################################################
resource "aws_route53_record" "simulator_record" {
  for_each = var.vpc_pn_vpn_is_enabled ? { "enabled" = true } : {}

  zone_id = aws_route53_zone.vpn.zone_id
  name    = "simulator"
  type    = "A"

  alias {
    name                   = aws_lb.pn_vpn_ecs_alb.dns_name
    zone_id                = aws_lb.pn_vpn_ecs_alb.zone_id
    evaluate_target_health = true
  }
}

###########################################################
#####    ACM Certificare for simulator.vpn.<domain>   ##### 
###########################################################
resource "aws_acm_certificate" "simulator_app" {
  domain_name       = format("simulator.vpn.%s", var.dns_zone)
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "simulator_app_cert_validation" {
  for_each = var.vpc_pn_vpn_is_enabled ? {
    for dvo in aws_acm_certificate.simulator_app.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  zone_id = data.aws_route53_zone.base_domain_name.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "simulator_app" {
  for_each = var.vpc_pn_vpn_is_enabled ? { "enabled" = true } : {}

  certificate_arn         = aws_acm_certificate.simulator_app.arn
  validation_record_fqdns = [for record in aws_route53_record.simulator_app_cert_validation : record.fqdn]
}