
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
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-core_vpc-webapp-.*$")
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
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^ELB net/WebI-.*$")
  }
}
# - API GW (Web) VPC Link
resource "aws_api_gateway_vpc_link" "pn_core_api_gw_vpc_lik" {
  name        = "PNCore-Web_B2B-VpcLink"
  description = "PN Core - Web Api GW Ingress - VPC Link"
  target_arns = [aws_lb.pn_core_api_gw_nlb.arn]
}
# - API-GW (Web) NLB listener for HTTP
resource "aws_lb_listener" "pn_core_api_gw_nlb_http_to_alb_http" {
  load_balancer_arn = aws_lb.pn_core_api_gw_nlb.arn
  protocol = "TCP"
  port     = 8080

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_api_gw_nlb_http_to_alb_http.arn
  }
}
# - API-GW (Web) NLB target group for HTTP
resource "aws_lb_target_group" "pn_core_api_gw_nlb_http_to_alb_http" {
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
resource "aws_lb_target_group_attachment" "pn_core_api_gw_nlb_http_to_alb_http" {
  target_group_arn  = aws_lb_target_group.pn_core_api_gw_nlb_http_to_alb_http.arn
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
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^ELB net/RaddI-.*$")
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
resource "aws_lb_listener" "pn_core_radd_nlb_http_to_alb_http" {
  load_balancer_arn = aws_lb.pn_core_radd_nlb.arn
  protocol = "TCP"
  port     = 8080

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_radd_nlb_http_to_alb_http.arn
  }
}
# - RADD NLB target group for HTTP
resource "aws_lb_target_group" "pn_core_radd_nlb_http_to_alb_http" {
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
resource "aws_lb_target_group_attachment" "pn_core_radd_nlb_http_to_alb_http" {
  target_group_arn  = aws_lb_target_group.pn_core_radd_nlb_http_to_alb_http.arn
  port              = 8080

  target_id         = aws_lb.pn_core_ecs_alb.arn
}

# - RADD NLB listener for HTTPS
resource "aws_lb_listener" "pn_core_radd_nlb_https_to_nlb_http" {
  load_balancer_arn = aws_lb.pn_core_radd_nlb.arn
  protocol = "TLS"
  port     = 8443
  
  alpn_policy = "None"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = module.acm_api["api.radd"].acm_certificate_arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_radd_nlb_https_to_nlb_http.arn
  }
}
# - RADD NLB target group for HTTPS
resource "aws_lb_target_group" "pn_core_radd_nlb_https_to_nlb_http" {
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
resource "aws_lb_target_group_attachment" "pn_core_radd_nlb_https_to_nlb_http" {
  count = var.how_many_az

  target_group_arn  = aws_lb_target_group.pn_core_radd_nlb_https_to_nlb_http.arn
  port              = 8080

  target_id         = cidrhost( local.Core_NlbRadd_SubnetsCidrs[count.index], 8)
  availability_zone = local.azs_names[count.index]
}



resource "aws_network_acl" "call_8080_do_not_receive" {
  vpc_id = module.vpc_pn_core.vpc_id

  dynamic "egress" {
    for_each = local.Core_SubnetsCidrs

    content {
      protocol   = "tcp"
      rule_no    = 1000 + 100 * egress.key
      action     = "allow"
      cidr_block = egress.value
      from_port  = 8080
      to_port    = 8080
    }
  }

  dynamic "ingress" {
    for_each = local.Core_SubnetsCidrs

    content {
      protocol   = "tcp"
      rule_no    = 1000 + 100 * ingress.key
      action     = "allow"
      cidr_block = ingress.value
      from_port  = 1024
      to_port    = 8079
    }
  }

  dynamic "ingress" {
    for_each = local.Core_SubnetsCidrs

    content {
      protocol   = "tcp"
      rule_no    = 2000 + 100 * ingress.key
      action     = "allow"
      cidr_block = ingress.value
      from_port  = 8081
      to_port    = 65535
    }
  }

  tags = {
    Name = "Outbound 8080 to ALB not inbound"
  }
}

resource "aws_network_acl_association" "nlb_web" {
  count = length( local.Core_NlbWeb_SubnetsIds )

  network_acl_id = aws_network_acl.call_8080_do_not_receive.id
  subnet_id      = local.Core_NlbWeb_SubnetsIds[ count.index ]
}

resource "aws_network_acl_association" "nlb_radd" {
  count = length( local.Core_NlbRadd_SubnetsIds )

  network_acl_id = aws_network_acl.call_8080_do_not_receive.id
  subnet_id      = local.Core_NlbRadd_SubnetsIds[ count.index ]
}

# service desk
# - NLB Di ingresso per le invocazioni da rete Service Desk
resource "aws_lb" "pn_core_servicedesk_nlb" {
  name_prefix = "SeDeI-"

  internal = true
  ip_address_type = "ipv4"
  load_balancer_type = "network"

  dynamic "subnet_mapping" {
    for_each = range(var.how_many_az)

    content {
      private_ipv4_address = cidrhost( local.Core_NlbServiceDesk_SubnetsCidrs[subnet_mapping.key], 8)
      subnet_id = local.Core_NlbServiceDesk_SubnetsIds[subnet_mapping.key]
    }
  }

  tags = {
    "Name": "PN Core - Service Desk Ingress - NLB"
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^ELB net/SeDeI-.*$")
  }
}

# - ServiceEndpoint ingresso per le invocazioni a Service Desk
resource "aws_vpc_endpoint_service" "pn_core_servicedesk_endpoint_svc" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.pn_core_servicedesk_nlb.arn]
  allowed_principals         = ["arn:aws:iam::${var.pn_servicedesk_aws_account_id}:root"]

  tags = {
    "Name": "PN Core - Service Desk - SVC endpoint"
  }
}
# - ServiceDesk NLB listener for HTTP
resource "aws_lb_listener" "pn_core_servicedesk_nlb_http_to_alb_http" {
  load_balancer_arn = aws_lb.pn_core_servicedesk_nlb.arn
  protocol = "TCP"
  port     = 8080

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pn_core_servicedeskin_nlb_http_to_alb_http.arn
  }
}
# - Service Desk NLB target group for HTTP
resource "aws_lb_target_group" "pn_core_servicedeskin_nlb_http_to_alb_http" {
  name_prefix = "SeDeI-"
  vpc_id      = module.vpc_pn_core.vpc_id

  port        = 8080
  protocol    = "TCP"
  target_type = "alb"
  
  depends_on = [
    aws_lb.pn_core_servicedesk_nlb,
    aws_lb.pn_core_ecs_alb
  ]

  tags = {
    "Description": "PN Core - Service Desk NLB to ALB - Target Group"
  }

  health_check {
    enabled = true
    matcher = "200-499"
  }
}
resource "aws_lb_target_group_attachment" "pn_core_servicedeskin_nlb_http_to_alb_http" {
  target_group_arn  = aws_lb_target_group.pn_core_servicedeskin_nlb_http_to_alb_http.arn
  port              = 8080

  target_id         = aws_lb.pn_core_ecs_alb.arn
}