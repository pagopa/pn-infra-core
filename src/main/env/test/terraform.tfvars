
environment = "test"
how_many_az = 3
dns_zone = "test.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.pg"]
cdn_domains = ["selfcare","cittadini","login","imprese","www","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.pg"]
  
pn_core_aws_account_id = "151559006927"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-0c61021a745c4c6c7"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-06e9167128c810a62"
pn_cors_addictive_sources = "http://localhost:8090"
pn_auth_fleet_addictive_allowed_issuer = "https://dev.selfcare.pagopa.it,https://uat.selfcare.pagopa.it,https://pnpg.dev.selfcare.pagopa.it,https://pnpg.uat.selfcare.pagopa.it"
pn_cost_anomaly_detection_email = "pn-irt-team@pagopa.it"
pn_cost_anomaly_detection_threshold = "10"
pn_confinfo_aws_account_id = "771887334808"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-771887334808"
pn_radd_aws_account_id = "654090169999"
pn_servicedesk_aws_account_id = "533236674075"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.6.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.6.70.0/24","10.6.71.0/24","10.6.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.6.40.0/24","10.6.41.0/24","10.6.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (test) AZ 0","PN Core - PnCore Egress Subnet (test) AZ 1","PN Core - PnCore Egress Subnet (test) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.6.1.0/28","10.6.1.16/28","10.6.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (test) AZ 0","PN Core - Public Subnet (test) AZ 1","PN Core - Public Subnet (test) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.6.3.0/28","10.6.3.16/28","10.6.3.32/28","10.6.5.0/28","10.6.5.16/28","10.6.5.32/28","10.6.20.0/24","10.6.21.0/24","10.6.22.0/24","10.6.60.0/24","10.6.61.0/24","10.6.62.0/24","10.6.70.0/24","10.6.71.0/24","10.6.72.0/24","10.6.80.0/24","10.6.81.0/24","10.6.82.0/24","10.6.7.0/28","10.6.7.16/28","10.6.7.32/28"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (test) AZ 0","PN Core - API-GW VpcLink Subnet (test) AZ 1","PN Core - API-GW VpcLink Subnet (test) AZ 2","PN Core - RADD Ingress Subnet (test) AZ 0","PN Core - RADD Ingress Subnet (test) AZ 1","PN Core - RADD Ingress Subnet (test) AZ 2","PN Core - PnCore Subnet (test) AZ 0","PN Core - PnCore Subnet (test) AZ 1","PN Core - PnCore Subnet (test) AZ 2","PN Core - To Confidential Info Subnet (test) AZ 0","PN Core - To Confidential Info Subnet (test) AZ 1","PN Core - To Confidential Info Subnet (test) AZ 2","PN Core - AWS Services Subnet (test) AZ 0","PN Core - AWS Services Subnet (test) AZ 1","PN Core - AWS Services Subnet (test) AZ 2","PN Core - OpenSearch Subnet (test) AZ 0","PN Core - OpenSearch Subnet (test) AZ 1","PN Core - OpenSearch Subnet (test) AZ 2","PN Core - Service Desk Ingress Subnet (test) AZ 0","PN Core - Service Desk Ingress Subnet (test) AZ 1","PN Core - Service Desk Ingress Subnet (test) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.6.3.0/28","10.6.3.16/28","10.6.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.6.5.0/28","10.6.5.16/28","10.6.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.6.20.0/24","10.6.21.0/24","10.6.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.6.40.0/24","10.6.41.0/24","10.6.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.6.60.0/24","10.6.61.0/24","10.6.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.6.80.0/24","10.6.81.0/24","10.6.82.0/24"]
vpc_pn_core_servicedesk_subnets_cidrs = ["10.6.7.0/28","10.6.7.16/28","10.6.7.32/28"]


