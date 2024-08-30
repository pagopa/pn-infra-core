
environment = "prod"
how_many_az = 3
dns_zone = "notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.pg"]
cdn_domains = ["selfcare","cittadini","login","imprese","www","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.pg"]
  
pn_core_aws_account_id = "510769970275"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-056fd08051998e388"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-0c36fae336946e891"
pn_cors_addictive_sources = ""
pn_auth_fleet_addictive_allowed_issuer = "https://selfcare.pagopa.it,https://pnpg.selfcare.pagopa.it"
pn_cost_anomaly_detection_email = "pn-irt-team@pagopa.it"
pn_cost_anomaly_detection_threshold = "10"
pn_confinfo_aws_account_id = "350578575906"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-350578575906"
pn_radd_aws_account_id = "510769970275"
pn_servicedesk_aws_account_id = "277345554283"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.10.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.10.70.0/24","10.10.71.0/24","10.10.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.10.40.0/24","10.10.41.0/24","10.10.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (prod) AZ 0","PN Core - PnCore Egress Subnet (prod) AZ 1","PN Core - PnCore Egress Subnet (prod) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.10.1.0/28","10.10.1.16/28","10.10.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (prod) AZ 0","PN Core - Public Subnet (prod) AZ 1","PN Core - Public Subnet (prod) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.10.3.0/28","10.10.3.16/28","10.10.3.32/28","10.10.5.0/28","10.10.5.16/28","10.10.5.32/28","10.10.20.0/24","10.10.21.0/24","10.10.22.0/24","10.10.60.0/24","10.10.61.0/24","10.10.62.0/24","10.10.70.0/24","10.10.71.0/24","10.10.72.0/24","10.10.80.0/24","10.10.81.0/24","10.10.82.0/24","10.10.7.0/28","10.10.7.16/28","10.10.7.32/28"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (prod) AZ 0","PN Core - API-GW VpcLink Subnet (prod) AZ 1","PN Core - API-GW VpcLink Subnet (prod) AZ 2","PN Core - RADD Ingress Subnet (prod) AZ 0","PN Core - RADD Ingress Subnet (prod) AZ 1","PN Core - RADD Ingress Subnet (prod) AZ 2","PN Core - PnCore Subnet (prod) AZ 0","PN Core - PnCore Subnet (prod) AZ 1","PN Core - PnCore Subnet (prod) AZ 2","PN Core - To Confidential Info Subnet (prod) AZ 0","PN Core - To Confidential Info Subnet (prod) AZ 1","PN Core - To Confidential Info Subnet (prod) AZ 2","PN Core - AWS Services Subnet (prod) AZ 0","PN Core - AWS Services Subnet (prod) AZ 1","PN Core - AWS Services Subnet (prod) AZ 2","PN Core - OpenSearch Subnet (prod) AZ 0","PN Core - OpenSearch Subnet (prod) AZ 1","PN Core - OpenSearch Subnet (prod) AZ 2","PN Core - Service Desk Ingress Subnet (prod) AZ 0","PN Core - Service Desk Ingress Subnet (prod) AZ 1","PN Core - Service Desk Ingress Subnet (prod) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.10.3.0/28","10.10.3.16/28","10.10.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.10.5.0/28","10.10.5.16/28","10.10.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.10.20.0/24","10.10.21.0/24","10.10.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.10.40.0/24","10.10.41.0/24","10.10.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.10.60.0/24","10.10.61.0/24","10.10.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.10.80.0/24","10.10.81.0/24","10.10.82.0/24"]
vpc_pn_core_servicedesk_subnets_cidrs = ["10.10.7.0/28","10.10.7.16/28","10.10.7.32/28"]


