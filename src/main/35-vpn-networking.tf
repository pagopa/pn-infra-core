module "vpc_pn_vpn" {
  for_each = var.vpc_pn_vpn_is_enabled ? { "enabled" = true } : {}

  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = var.vpc_pn_vpn_name
  cidr = var.vpc_pn_vpn_cidr

  azs                 = local.azs_names
  intra_subnets       = var.vpc_pn_vpn_internal_subnets_cidr
  private_subnets     = var.vpc_pn_vpn_private_subnets_cidr
  public_subnets      = var.vpc_pn_vpn_public_subnets_cidr
  
  intra_subnet_names       = var.vpc_pn_vpn_internal_subnets_names
  private_subnet_names     = var.vpc_pn_vpn_private_subnets_names
  public_subnet_names      = var.vpc_pn_vpn_public_subnets_names

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  enable_vpn_gateway = true

  enable_dhcp_options = false

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
  
  map_public_ip_on_launch = true
  

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  tags = { 
    "Code" = "pn-vpn",
    "Terraform" = "true",
    "Environment" = var.environment,
    "pn-eni-related" = "true"
  }
}


resource "aws_security_group" "vpc_pn_vpn_secgrp_tls" {
  name_prefix = "pn-vpn_vpc-tls-secgrp"
  description = "Allow TLS inbound traffic from VPN"
  vpc_id      = module.vpc_pn_vpn["enabled"].vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_vpn_primary_cidr]
  }
}

module "vpc_endpoints_pn_vpn" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.17.0"

  vpc_id             = module.vpc_pn_vpn["enabled"].vpc_id
  security_group_ids = [ aws_security_group.vpc_pn_vpn_secgrp_tls.id ]
  subnet_ids         = [ 
        for idx, cidr in module.vpc_pn_vpn["enabled"].intra_subnets_cidr_blocks :
          module.vpc_pn_vpn["enabled"].intra_subnets[idx]
          if contains(var.vpc_pn_vpn_aws_services_interface_endpoints_subnets_cidr, cidr)
      ]
  
  tags = {
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-vpn_vpc-tls-.*$")
  }

  endpoints = merge(
    {
      for svc_name in var.vpc_endpoints_pn_vpn:
        svc_name => {
          service             = svc_name
          private_dns_enabled = true  
          tags                = { Name = "AWS Endpoint ${svc_name} - pn-vpn - ${var.environment}"}
        }
    },
    {
      s3 = {
        service         = "s3"
        service_type    = "Gateway"
        route_table_ids = flatten([
          module.vpc_pn_vpn["enabled"].intra_route_table_ids
        ])
        tags                = { Name = "AWS Endpoint s3 - pn-vpn - ${var.environment}"}
      },
    }
  )
}
