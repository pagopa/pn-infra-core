###########################################################
#####       Application Load Balancer (Internal)      #####
###########################################################
resource "aws_lb" "pn_vpn_ecs_alb" {
  name_prefix        = "EcsA-"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_vpn_sg.id]
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
#####              Target Group per ECS               #####
###########################################################
resource "aws_lb_target_group" "simulator_tg" {
  name                 = "simulator"
  port                 = 8080                    
  protocol             = "HTTP"
  vpc_id               = module.vpc_pn_vpn["enabled"].vpc_id
  target_type          = "ip"                    

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
    path                = "/"                    
    matcher             = "200-399"
  }

  deregistration_delay = 30
}

###########################################################
#####                Listener HTTPS                   #####
###########################################################
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.pn_vpn_ecs_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.simulator_app.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.simulator_tg.arn
  }
}

###########################################################
####       Listener HTTP (redirect verso HTTPS)        ####
###########################################################
resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.pn_vpn_ecs_alb.arn
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###########################################################
# ECS Service -> ALB Target Group binding (da inserire nel service)
###########################################################
# Esempio da mettere nella definizione ECS service:
#
# load_balancer {
#   target_group_arn = aws_lb_target_group.simulator_tg.arn
#   container_name   = "django"        # deve combaciare col nome nel task definition
#   container_port   = 8000            # porta container Django
# }
