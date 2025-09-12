module "vpc_pn_core" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = var.vpc_pn_core_name
  cidr = var.vpc_pn_core_primary_cidr

  azs                 = local.azs_names
  private_subnets     = var.vpc_pn_core_private_subnets_cidr
  public_subnets      = var.vpc_pn_core_public_subnets_cidr
  intra_subnets       = var.vpc_pn_core_internal_subnets_cidr

  private_subnet_names     = var.vpc_pn_core_private_subnets_names
  public_subnet_names      = var.vpc_pn_core_public_subnets_names
  intra_subnet_names       = var.vpc_pn_core_internal_subnets_names

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  enable_vpn_gateway = false

  enable_dhcp_options              = false

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
    "Code" = "pn-core",
    "Terraform" = "true",
    "Environment" = var.environment,
    "pn-eni-related" = "true"
    "pn-eni-related-description-regexp" = base64encode("^Interface for NAT Gateway.*$")
  }
}


resource "aws_security_group" "vpc_pn_core__secgrp_tls" {
  
  name_prefix = "pn-core_vpc-tls-secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_pn_core.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_core_primary_cidr]
  }

}

module "vpc_endpoints_pn_core" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.17.0"

  vpc_id             = module.vpc_pn_core.vpc_id
  security_group_ids = [ aws_security_group.vpc_pn_core__secgrp_tls.id ]
  subnet_ids         = [ 
        for cidr in var.vpc_pn_core_aws_services_interface_endpoints_subnets_cidr:
          module.vpc_pn_core.intra_subnets[
              index( module.vpc_pn_core.intra_subnets_cidr_blocks, cidr )
            ]
      ]
  
  tags = {
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-core_vpc-tls-.*$")
  }

  endpoints = merge(
    {
      for svc_name in var.vpc_endpoints_pn_core:
        svc_name => {
          service             = svc_name
          private_dns_enabled = true  
          tags                = { Name = "AWS Endpoint ${svc_name} - pn-core - ${var.environment}"}
        }
    },
    {
      dynamodb = {
        service         = "dynamodb"
        service_type    = "Gateway"
        route_table_ids = flatten([
          module.vpc_pn_core.intra_route_table_ids, 
          module.vpc_pn_core.private_route_table_ids 
        ])
        tags                = { Name = "AWS Endpoint dynamodb - pn-core - ${var.environment}"}
      },
      s3 = {
        service         = "s3"
        service_type    = "Gateway"
        route_table_ids = flatten([
          module.vpc_pn_core.intra_route_table_ids, 
          module.vpc_pn_core.private_route_table_ids 
        ])
        tags                = { Name = "AWS Endpoint s3 - pn-core - ${var.environment}"}
      },
    }
  )
}



resource "aws_security_group" "vpc_pn_core__secgrp_toconfidentialinfo" {
  
  name_prefix = "pn-core_vpc-toconfinfo-secgrp"
  description = "Allow HTTP_8080 inbound traffic"
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

# PRIVATE LINK ENDPOINTS TO DataVault
resource "aws_vpc_endpoint" "to_data_vault" {
  vpc_id            = module.vpc_pn_core.vpc_id
  service_name      = var.pn_core_to_data_vault_vpcse
  vpc_endpoint_type = "Interface"

  security_group_ids = [ aws_security_group.vpc_pn_core__secgrp_toconfidentialinfo.id ]

  subnet_ids          = local.Core_ToConfinfo_SubnetsIds
  private_dns_enabled = false

  tags                = { 
    Name = "Endpoint to pn-data-vault"
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-core_vpc-toconfinfo-.*$")
  }
}

# PRIVATE LINK ENDPOINTS TO SafeStorage, EternalChannel
resource "aws_vpc_endpoint" "to_safestorage_extch" {
  vpc_id            = module.vpc_pn_core.vpc_id
  service_name      = var.pn_core_to_extch_safestorage_vpcse
  vpc_endpoint_type = "Interface"

  security_group_ids = [ aws_security_group.vpc_pn_core__secgrp_toconfidentialinfo.id ]

  subnet_ids          = local.Core_ToConfinfo_SubnetsIds
  private_dns_enabled = false

  tags                = { 
    Name = "Endpoint to pn-safestorage and pn-external-channel"
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-core_vpc-toconfinfo-.*$")
  }
}


# FIXME Creo una zona per risolvere alb.confidential.pn.internal allo scopo di raggiungere pn-data-vault
#   Andrebbero parametrizzati gli URL nei microservizi ma in attesa della parametrizzazione creiamo 
#   in pn-core una zona DNS privata per creare degli alias verso pn-confinfo
resource "aws_route53_zone" "fake_confidential_pn_internal" {
  name = "confidential.pn.internal"
  
  vpc {
    vpc_id = module.vpc_pn_core.vpc_id
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.fake_confidential_pn_internal.zone_id
  name    = "alb.confidential.pn.internal"
  type    = "CNAME"
  ttl     = "60"
  records = [ aws_vpc_endpoint.to_data_vault.dns_entry[0].dns_name ]
}



module "vpc_pn_simulator" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = var.vpc_pn_simulator_name
  cidr = var.vpc_pn_simulator_primary_cidr

  azs                 = local.azs_names
  private_subnets     = var.vpc_pn_simulator_private_subnets_cidr
  public_subnets      = var.vpc_pn_simulator_public_subnets_cidr
  intra_subnets       = var.vpc_pn_simulator_internal_subnets_cidr

  private_subnet_names     = var.vpc_pn_simulator_private_subnets_names
  public_subnet_names      = var.vpc_pn_simulator_public_subnets_names
  intra_subnet_names       = var.vpc_pn_simulator_internal_subnets_names

  create_database_subnet_group = false

  enable_dns_hostnames = false
  enable_dns_support   = false

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
    "Code" = "pn-simulator",
    "Terraform" = "true",
    "Environment" = var.environment,
    "pn-eni-related" = "true"
    #"pn-eni-related-description-regexp" = base64encode("^Interface for NAT Gateway.*$")
  }
}


resource "aws_security_group" "vpc_pn_simulator_secgrp_tls" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  name_prefix = "pn-simulator_vpc-tls-secgrp"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc_pn_simulator["enabled"].vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_pn_simulator_primary_cidr]
  }

}


module "vpc_endpoints_pn_simulator" {
  for_each = var.vpc_pn_simulator_is_enabled ? { "enabled" = true } : {}

  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "5.17.0"

  vpc_id             = module.vpc_pn_simulator["enabled"].vpc_id
  security_group_ids = [ aws_security_group.vpc_pn_simulator_secgrp_tls["enabled"].id ]
  subnet_ids         = [ 
        for idx, cidr in module.vpc_pn_simulator["enabled"].intra_subnets_cidr_blocks :
          module.vpc_pn_simulator["enabled"].intra_subnets[idx]
          if contains(var.vpc_pn_simulator_aws_services_interface_endpoints_subnets_cidr, cidr)
      ]
  
  tags = {
    "pn-eni-related" = "true"
    "pn-eni-related-groupName-regexp" = base64encode("^pn-simulator_vpc-tls-.*$")
  }

  endpoints = merge(
    {
      for svc_name in var.vpc_endpoints_pn_simulator:
        svc_name => {
          service             = svc_name
          private_dns_enabled = true  
          tags                = { Name = "AWS Endpoint ${svc_name} - pn-core - ${var.environment}"}
        }
    },
    {
      s3 = {
        service         = "s3"
        service_type    = "Gateway"
        route_table_ids = flatten([
          module.vpc_pn_simulator["enabled"].intra_route_table_ids, 
          module.vpc_pn_simulator["enabled"].private_route_table_ids 
        ])
        tags                = { Name = "AWS Endpoint s3 - pn-core - ${var.environment}"}
      },
    }
  )
}
