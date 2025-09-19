resource "aws_route53_zone" "vpn" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  name    = format("vpn.%s", var.dns_zone)
  comment = "Hosted zone privata per VPN e routing ALB" 
  vpc {
    vpc_id = module.vpc_pn_simulator["enabled"].vpc_id
  }
}

resource "aws_acm_certificate" "vpn" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  domain_name       = format("vpn.%s", var.dns_zone)
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "vpn_cert_validation" {
  for_each = var.vpc_pn_simulator_is_enabled ? {
    for dvo in aws_acm_certificate.vpn["enabled"].domain_validation_options : dvo.domain_name => {
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
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  certificate_arn         = aws_acm_certificate.vpn["enabled"].arn
  validation_record_fqdns = [for record in aws_route53_record.vpn_cert_validation : record.fqdn]
}

resource "aws_route53_record" "vpn_ns" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}
  
  zone_id = data.aws_route53_zone.base_domain_name.zone_id
  name    = format("vpn.%s", var.dns_zone)
  type    = "NS"
  ttl     = "300"
  records = aws_route53_zone.vpn["enabled"].name_servers
}

resource "aws_route53_record" "simulator_record" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  zone_id = aws_route53_zone.vpn["enabled"].zone_id
  name    = "simulator" # simulator.vpn.pippo.it
  type    = "A"

  alias {
    name                   = aws_lb.pn_simulator_ecs_alb.dns_name
    zone_id                = aws_lb.pn_simulator_ecs_alb.zone_id
    evaluate_target_health = true
  }
}
