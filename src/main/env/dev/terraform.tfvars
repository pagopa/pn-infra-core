
environment = "dev"
how_many_az = 3
dns_zone = "dev.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api-selcpg"]
cdn_domains = ["portale-pa","portale","portale-login","portale-pg","status","www"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api-selcpg"]
  
pn_core_aws_account_id = "830192246553"
pn_confinfo_aws_account_id = "089813480515"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.1.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.1.70.0/24","10.1.71.0/24","10.1.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs"]

vpc_pn_core_private_subnets_cidr = ["10.1.40.0/24","10.1.41.0/24","10.1.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (dev) AZ 0","PN Core - PnCore Egress Subnet (dev) AZ 1","PN Core - PnCore Egress Subnet (dev) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.1.1.0/28","10.1.1.16/28","10.1.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (dev) AZ 0","PN Core - Public Subnet (dev) AZ 1","PN Core - Public Subnet (dev) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.1.3.0/28","10.1.3.16/28","10.1.3.32/28","10.1.5.0/28","10.1.5.16/28","10.1.5.32/28","10.1.20.0/24","10.1.21.0/24","10.1.22.0/24","10.1.60.0/24","10.1.61.0/24","10.1.62.0/24","10.1.70.0/24","10.1.71.0/24","10.1.72.0/24","10.1.80.0/24","10.1.81.0/24","10.1.82.0/24"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (dev) AZ 0","PN Core - API-GW VpcLink Subnet (dev) AZ 1","PN Core - API-GW VpcLink Subnet (dev) AZ 2","PN Core - RADD Ingress Subnet (dev) AZ 0","PN Core - RADD Ingress Subnet (dev) AZ 1","PN Core - RADD Ingress Subnet (dev) AZ 2","PN Core - PnCore Subnet (dev) AZ 0","PN Core - PnCore Subnet (dev) AZ 1","PN Core - PnCore Subnet (dev) AZ 2","PN Core - To Confidential Info Subnet (dev) AZ 0","PN Core - To Confidential Info Subnet (dev) AZ 1","PN Core - To Confidential Info Subnet (dev) AZ 2","PN Core - AWS Services Subnet (dev) AZ 0","PN Core - AWS Services Subnet (dev) AZ 1","PN Core - AWS Services Subnet (dev) AZ 2","PN Core - OpenSearch Subnet (dev) AZ 0","PN Core - OpenSearch Subnet (dev) AZ 1","PN Core - OpenSearch Subnet (dev) AZ 2"]



