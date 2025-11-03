###########################################################
#####       Application Load Balancer (Internal)      #####
###########################################################
resource "aws_lb" "pn_vpn_ecs_alb" {
  count              = var.vpc_pn_vpn_is_enabled ? 1 : 0
  
  name_prefix        = "EcsA-"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_vpn_sg[0].id]
  subnets            = local.VPN_Services_Subnet_IDs

  enable_deletion_protection = false
  drop_invalid_header_fields = true

  tags = {
    Name                         = "PN VPN - ECS Cluster - ALB"
    pn-eni-related               = "true"
    pn-eni-related-groupName-regexp = base64encode("^pn-vpn_vpc-webapp-.*$")
  }
}


###########################################################
#####                Listener HTTPS                   #####
###########################################################
resource "aws_lb_listener" "https_listener" {
  count              = var.vpc_pn_vpn_is_enabled ? 1 : 0

  load_balancer_arn = aws_lb.pn_vpn_ecs_alb[0].arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.simulator_app[0].arn

  default_action {
    type = "fixed-response"
    
    fixed_response {
      content_type = "application/json"
      message_body = "{ \"error\": \"404\", \"message\": \"Load balancer rule not configured\" }"
      status_code  = "404"
    }
  }
}

###########################################################
####       Listener HTTP (redirect verso HTTPS)        ####
###########################################################
resource "aws_lb_listener" "http_redirect" {
  count              = var.vpc_pn_vpn_is_enabled ? 1 : 0

  load_balancer_arn = aws_lb.pn_vpn_ecs_alb[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

###########################################################
######             Security Group per ALB            ######
###########################################################
resource "aws_security_group" "alb_vpn_sg" {
  count       = var.vpc_pn_vpn_is_enabled ? 1 : 0

  name        = format("%s_alb_vpn_sg", var.environment)
  description = "Allow HTTPS/HTTP from VPN"
  vpc_id      = module.vpc_pn_vpn["enabled"].vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_vpn_primary_cidr]
    description = "Allow HTTPS from VPN"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_vpn_primary_cidr]
    description = "Allow HTTP (redirect)"
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [module.vpc_pn_vpn["enabled"].vpc_cidr_block]
  }
}

###########################################################
#####       simulator.vpn.<domain> → ALB internal     #####
###########################################################
resource "aws_route53_record" "simulator_record" {
  for_each = var.vpc_pn_vpn_is_enabled ? { "enabled" = true } : {}

  zone_id = aws_route53_zone.vpn[0].zone_id
  name    = "simulator"
  type    = "A"

  alias {
    name                   = aws_lb.pn_vpn_ecs_alb[0].dns_name
    zone_id                = aws_lb.pn_vpn_ecs_alb[0].zone_id
    evaluate_target_health = true
  }
}

