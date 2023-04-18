
environment = "dev"
how_many_az = 3
dns_zone = "dev.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg"]
cdn_domains = ["selfcare","cittadini","login","imprese","status","www","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg"]
  
pn_core_aws_account_id = "830192246553"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-05e7543f3ead0c903"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-07d53855bfe7d3c4a"
pn_cors_addictive_sources = "http://localhost:8090"
pn_auth_fleet_addictive_allowed_issuer = "https://dev.selfcare.pagopa.it,https://uat.selfcare.pagopa.it,https://pnpg.dev.selfcare.pagopa.it"
pn_confinfo_aws_account_id = "089813480515"
pn_safestorage_data_bucket_name = "pn-ss-storage-dev-pnssbucket-9znf9ge7935e"
pn_radd_aws_account_id = "830192246553"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.1.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.1.70.0/24","10.1.71.0/24","10.1.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.1.40.0/24","10.1.41.0/24","10.1.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (dev) AZ 0","PN Core - PnCore Egress Subnet (dev) AZ 1","PN Core - PnCore Egress Subnet (dev) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.1.1.0/28","10.1.1.16/28","10.1.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (dev) AZ 0","PN Core - Public Subnet (dev) AZ 1","PN Core - Public Subnet (dev) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.1.3.0/28","10.1.3.16/28","10.1.3.32/28","10.1.5.0/28","10.1.5.16/28","10.1.5.32/28","10.1.20.0/24","10.1.21.0/24","10.1.22.0/24","10.1.60.0/24","10.1.61.0/24","10.1.62.0/24","10.1.70.0/24","10.1.71.0/24","10.1.72.0/24","10.1.80.0/24","10.1.81.0/24","10.1.82.0/24"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (dev) AZ 0","PN Core - API-GW VpcLink Subnet (dev) AZ 1","PN Core - API-GW VpcLink Subnet (dev) AZ 2","PN Core - RADD Ingress Subnet (dev) AZ 0","PN Core - RADD Ingress Subnet (dev) AZ 1","PN Core - RADD Ingress Subnet (dev) AZ 2","PN Core - PnCore Subnet (dev) AZ 0","PN Core - PnCore Subnet (dev) AZ 1","PN Core - PnCore Subnet (dev) AZ 2","PN Core - To Confidential Info Subnet (dev) AZ 0","PN Core - To Confidential Info Subnet (dev) AZ 1","PN Core - To Confidential Info Subnet (dev) AZ 2","PN Core - AWS Services Subnet (dev) AZ 0","PN Core - AWS Services Subnet (dev) AZ 1","PN Core - AWS Services Subnet (dev) AZ 2","PN Core - OpenSearch Subnet (dev) AZ 0","PN Core - OpenSearch Subnet (dev) AZ 1","PN Core - OpenSearch Subnet (dev) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.1.3.0/28","10.1.3.16/28","10.1.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.1.5.0/28","10.1.5.16/28","10.1.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.1.20.0/24","10.1.21.0/24","10.1.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.1.40.0/24","10.1.41.0/24","10.1.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.1.60.0/24","10.1.61.0/24","10.1.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.1.80.0/24","10.1.81.0/24","10.1.82.0/24"]


