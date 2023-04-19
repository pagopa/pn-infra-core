
resource "aws_security_group" "vpc_pn_core__secgrp_webapp" {
  
  name_prefix = "pn-core_vpc-webapp-secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_pn_core.vpc_id

  ingress {
    description = "8080 from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_core_primary_cidr]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}



# - ECS cluster Application load balancer 
resource "aws_lb" "pn_core_ecs_alb" {
  name_prefix        = "EcsA-"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc_pn_core__secgrp_webapp.id]
  subnets            = local.Core_SubnetsIds

  enable_deletion_protection = false

  tags = {
    "Name": "PN Core - ECS Cluster - ALB"
  }
}
# - ECS cluster Application load balancer HTTP listener
resource "aws_lb_listener" "pn_core_ecs_alb_8080" {
  load_balancer_arn = aws_lb.pn_core_ecs_alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "application/json"
      message_body = "{ \"error\": \"404\", \"message\": \"Load balancer rule not configured\" }"
      status_code  = "404"
    }
  }
}



# - NLB Di ingresso per le invocazioni dal web
resource "aws_lb" "pn_core_api_gw_nlb" {
  name_prefix = "WebI-"

  internal = true
  ip_address_type = "ipv4"
  load_balancer_type = "network"


  dynamic "subnet_mapping" {
    for_each = range(var.how_many_az)

    content {
      private_ipv4_address = cidrhost( local.Core_NlbWeb_SubnetsCidrs[subnet_mapping.key], 8)
      subnet_id = local.Core_NlbWeb_SubnetsIds[subnet_mapping.key]
    }
  }

  tags = {
    "Name": "PN Core - Web Api GW Ingress - NLB"
  }
}
# - API GW (Web) VPC Link
resource "aws_api_gateway_vpc_link" "pn_core_api_gw_vpc_lik" {
  name        = "PNCore-Web_B2B-VpcLink"
  description = "PN Core - Web Api GW Ingress - VPC Link"
  target_arns = [aws_lb.pn_core_api_gw_nlb.arn]
}
# - API-GW (Web) NLB listener for HTTP
resource "aws_lb_listener" "pn_core_api_gw_nlb_8080_to_alb_8080" {
  load_balancer_arn = aws_lb.pn_core_api_gw_nlb.arn
  protocol = "TCP"
  port     = 8080

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_api_gw_nlb_8080_to_alb_8080.arn
  }
}
# - API-GW (Web) NLB target group for HTTP
resource "aws_lb_target_group" "pn_core_api_gw_nlb_8080_to_alb_8080" {
  name_prefix = "WebI-"
  vpc_id      = module.vpc_pn_core.vpc_id

  port        = 8080
  protocol    = "TCP"
  target_type = "alb"
  
  depends_on = [
    aws_lb.pn_core_api_gw_nlb,
    aws_lb.pn_core_ecs_alb
  ]

  tags = {
    "Description": "PN Core - Web Api GW Ingress NLB to ALB - Target Group"
  }

  health_check {
    enabled = true
    matcher = "200-499"
  }
}
# - API-GW (Web) NLB target group for HTTP attachement
resource "aws_lb_target_group_attachment" "pn_core_api_gw_nlb_8080_to_alb_8080" {
  target_group_arn  = aws_lb_target_group.pn_core_api_gw_nlb_8080_to_alb_8080.arn
  port              = 8080

  target_id         = aws_lb.pn_core_ecs_alb.arn
}



# - NLB Di ingresso per le invocazioni da rete RADD
resource "aws_lb" "pn_core_radd_nlb" {
  name_prefix = "RaddI-"

  internal = true
  ip_address_type = "ipv4"
  load_balancer_type = "network"

  dynamic "subnet_mapping" {
    for_each = range(var.how_many_az)

    content {
      private_ipv4_address = cidrhost( local.Core_NlbRadd_SubnetsCidrs[subnet_mapping.key], 8)
      subnet_id = local.Core_NlbRadd_SubnetsIds[subnet_mapping.key]
    }
  }

  tags = {
    "Name": "PN Core - Radd Ingress - NLB"
  }
}
# - ServiceEndpoint ingresso per le invocazioni a ExternalChannel e SafeStorage
resource "aws_vpc_endpoint_service" "pn_core_radd_endpoint_svc" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.pn_core_radd_nlb.arn]
  allowed_principals         = ["arn:aws:iam::${var.pn_radd_aws_account_id}:root"]

  tags = {
    "Name": "PN Core - RADD - SVC endpoint"
  }
}
# - RADD NLB listener for HTTP
resource "aws_lb_listener" "pn_core_radd_nlb_8080_to_alb_8080" {
  load_balancer_arn = aws_lb.pn_core_radd_nlb.arn
  protocol = "TCP"
  port     = 8080

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_radd_nlb_8080_to_alb_8080.arn
  }
}
# - RADD NLB target group for HTTP
resource "aws_lb_target_group" "pn_core_radd_nlb_8080_to_alb_8080" {
  name_prefix = "RaddI-"
  vpc_id      = module.vpc_pn_core.vpc_id

  port        = 8080
  protocol    = "TCP"
  target_type = "alb"
  
  depends_on = [
    aws_lb.pn_core_radd_nlb,
    aws_lb.pn_core_ecs_alb
  ]

  tags = {
    "Description": "PN Core - RADD NLB to ALB - Target Group"
  }

  health_check {
    enabled = true
    matcher = "200-499"
  }
}
# - RADD NLB target group for HTTP attachmet
resource "aws_lb_target_group_attachment" "pn_core_radd_nlb_8080_to_alb_8080" {
  target_group_arn  = aws_lb_target_group.pn_core_radd_nlb_8080_to_alb_8080.arn
  port              = 8080

  target_id         = aws_lb.pn_core_ecs_alb.arn
}

# - RADD NLB listener for HTTPS
resource "aws_lb_listener" "pn_core_radd_nlb_8443_to_nlb_8080" {
  load_balancer_arn = aws_lb.pn_core_radd_nlb.arn
  protocol = "TLS"
  port     = 8443
  
  alpn_policy = "None"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = module.acm_api["api.radd"].acm_certificate_arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_radd_nlb_8443_to_nlb_8080.arn
  }
}
# - RADD NLB target group for HTTPS
resource "aws_lb_target_group" "pn_core_radd_nlb_8443_to_nlb_8080" {
  name_prefix = "RaddT-"
  vpc_id      = module.vpc_pn_core.vpc_id

  port        = 8080
  protocol    = "TCP"
  target_type = "ip"
  
  tags = {
    "Description": "PN Core - RADD NLB TLS termination - Target Group"
  }

  health_check {
    enabled = true
    path = "/"
    matcher = "200-499"
  }
}
resource "aws_lb_target_group_attachment" "pn_core_radd_nlb_8443_to_nlb_8080" {
  count = var.how_many_az

  target_group_arn  = aws_lb_target_group.pn_core_radd_nlb_8443_to_nlb_8080.arn
  port              = 8080

  target_id         = cidrhost( local.Core_NlbRadd_SubnetsCidrs[count.index], 8)
  availability_zone = local.azs_names[count.index]
}
