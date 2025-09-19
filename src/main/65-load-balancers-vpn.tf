# - ECS cluster Application load balancer 
resource "aws_lb" "pn_simulator_ecs_alb" {
  name_prefix        = "EcsA-"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_simulator_sg["enabled"].id]
  subnets            = local.Simulator_Services_Subnet_IDs

  enable_deletion_protection = false

  drop_invalid_header_fields = true

  tags = {
    "Name": "PN Simulator - ECS Cluster - ALB"
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-simulator_vpc-webapp-.*$")
  }
}

# Target Group
resource "aws_lb_target_group" "simulator_tg" {
  name     = "simulator"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = module.vpc_pn_simulator["enabled"].vpc_id
  
}

# - ECS cluster Application load balancer HTTP listener
resource "aws_lb_listener" "pn_simulator_ecs_alb_8080" {
  load_balancer_arn = aws_lb.pn_simulator_ecs_alb.arn
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

resource "aws_security_group" "alb_simulator_sg" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  name   = format("%s_alb_simulator_sg", var.environment)
  vpc_id = module.vpc_pn_simulator["enabled"].vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_simulator_primary_cidr] # Solo traffico dal VPN Client
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}