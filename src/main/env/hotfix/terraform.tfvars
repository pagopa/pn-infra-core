
environment = "hotfix"
how_many_az = 3
dns_zone = "hotfix.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn"]
cdn_domains = ["selfcare","cittadini","login","imprese","status","www","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn"]
  
pn_core_aws_account_id = "207905393513"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-028e57d02dfd2ba53"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-09f2a367f89a819f3"
pn_cors_addictive_sources = ""
pn_auth_fleet_addictive_allowed_issuer = "https://uat.selfcare.pagopa.it,https://pnpg.uat.selfcare.pagopa.it"
pn_confinfo_aws_account_id = "839620963891"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-839620963891"
pn_radd_aws_account_id = "830192246553"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.14.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.14.70.0/24","10.14.71.0/24","10.14.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.14.40.0/24","10.14.41.0/24","10.14.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (hotfix) AZ 0","PN Core - PnCore Egress Subnet (hotfix) AZ 1","PN Core - PnCore Egress Subnet (hotfix) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.14.1.0/28","10.14.1.16/28","10.14.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (hotfix) AZ 0","PN Core - Public Subnet (hotfix) AZ 1","PN Core - Public Subnet (hotfix) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.14.3.0/28","10.14.3.16/28","10.14.3.32/28","10.14.5.0/28","10.14.5.16/28","10.14.5.32/28","10.14.20.0/24","10.14.21.0/24","10.14.22.0/24","10.14.60.0/24","10.14.61.0/24","10.14.62.0/24","10.14.70.0/24","10.14.71.0/24","10.14.72.0/24","10.14.80.0/24","10.14.81.0/24","10.14.82.0/24"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (hotfix) AZ 0","PN Core - API-GW VpcLink Subnet (hotfix) AZ 1","PN Core - API-GW VpcLink Subnet (hotfix) AZ 2","PN Core - RADD Ingress Subnet (hotfix) AZ 0","PN Core - RADD Ingress Subnet (hotfix) AZ 1","PN Core - RADD Ingress Subnet (hotfix) AZ 2","PN Core - PnCore Subnet (hotfix) AZ 0","PN Core - PnCore Subnet (hotfix) AZ 1","PN Core - PnCore Subnet (hotfix) AZ 2","PN Core - To Confidential Info Subnet (hotfix) AZ 0","PN Core - To Confidential Info Subnet (hotfix) AZ 1","PN Core - To Confidential Info Subnet (hotfix) AZ 2","PN Core - AWS Services Subnet (hotfix) AZ 0","PN Core - AWS Services Subnet (hotfix) AZ 1","PN Core - AWS Services Subnet (hotfix) AZ 2","PN Core - OpenSearch Subnet (hotfix) AZ 0","PN Core - OpenSearch Subnet (hotfix) AZ 1","PN Core - OpenSearch Subnet (hotfix) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.14.3.0/28","10.14.3.16/28","10.14.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.14.5.0/28","10.14.5.16/28","10.14.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.14.20.0/24","10.14.21.0/24","10.14.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.14.40.0/24","10.14.41.0/24","10.14.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.14.60.0/24","10.14.61.0/24","10.14.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.14.80.0/24","10.14.81.0/24","10.14.82.0/24"]


