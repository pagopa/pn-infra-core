
environment = "uat"
how_many_az = 3
dns_zone = "uat.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
cdn_domains = ["selfcare","cittadini","login","imprese","www","showcase","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
  
pn_core_aws_account_id = "644374009812"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-0137ff603c40224ec"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-0d3e538b0b0956de4"
pn_cors_addictive_sources = ""
pn_auth_fleet_addictive_allowed_issuer = "https://uat.selfcare.pagopa.it,https://pnpg.uat.selfcare.pagopa.it"
pn_cost_anomaly_detection_email = "pn-irt-team@pagopa.it"
pn_cost_anomaly_detection_threshold = "10"
generate_landing_multi_domain_cdn_cert = true
enable_landing_cdn_redirect_function = false
landing_cdn_allowed_internal_zones = ["uat.notifichedigitali.it"]
landing_cdn_allowed_external_zones = ["notifichedigitali.pagopa.it"]
landing_multi_domain_cert_domains = ["showcase.uat.notifichedigitali.it","www.uat.notifichedigitali.it","uat.notifichedigitali.pagopa.it","www.uat.notifichedigitali.pagopa.it"]
landing_single_domain = "www"
pn_confinfo_aws_account_id = "956319218727"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-956319218727"
pn_radd_aws_account_id = "554102482368"
pn_servicedesk_aws_account_id = "533236674075"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.7.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.7.70.0/24","10.7.71.0/24","10.7.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.7.40.0/24","10.7.41.0/24","10.7.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (uat) AZ 0","PN Core - PnCore Egress Subnet (uat) AZ 1","PN Core - PnCore Egress Subnet (uat) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.7.1.0/28","10.7.1.16/28","10.7.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (uat) AZ 0","PN Core - Public Subnet (uat) AZ 1","PN Core - Public Subnet (uat) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.7.3.0/28","10.7.3.16/28","10.7.3.32/28","10.7.5.0/28","10.7.5.16/28","10.7.5.32/28","10.7.20.0/24","10.7.21.0/24","10.7.22.0/24","10.7.60.0/24","10.7.61.0/24","10.7.62.0/24","10.7.70.0/24","10.7.71.0/24","10.7.72.0/24","10.7.80.0/24","10.7.81.0/24","10.7.82.0/24","10.7.7.0/28","10.7.7.16/28","10.7.7.32/28"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (uat) AZ 0","PN Core - API-GW VpcLink Subnet (uat) AZ 1","PN Core - API-GW VpcLink Subnet (uat) AZ 2","PN Core - RADD Ingress Subnet (uat) AZ 0","PN Core - RADD Ingress Subnet (uat) AZ 1","PN Core - RADD Ingress Subnet (uat) AZ 2","PN Core - PnCore Subnet (uat) AZ 0","PN Core - PnCore Subnet (uat) AZ 1","PN Core - PnCore Subnet (uat) AZ 2","PN Core - To Confidential Info Subnet (uat) AZ 0","PN Core - To Confidential Info Subnet (uat) AZ 1","PN Core - To Confidential Info Subnet (uat) AZ 2","PN Core - AWS Services Subnet (uat) AZ 0","PN Core - AWS Services Subnet (uat) AZ 1","PN Core - AWS Services Subnet (uat) AZ 2","PN Core - OpenSearch Subnet (uat) AZ 0","PN Core - OpenSearch Subnet (uat) AZ 1","PN Core - OpenSearch Subnet (uat) AZ 2","PN Core - Service Desk Ingress Subnet (uat) AZ 0","PN Core - Service Desk Ingress Subnet (uat) AZ 1","PN Core - Service Desk Ingress Subnet (uat) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.7.3.0/28","10.7.3.16/28","10.7.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.7.5.0/28","10.7.5.16/28","10.7.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.7.20.0/24","10.7.21.0/24","10.7.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.7.40.0/24","10.7.41.0/24","10.7.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.7.60.0/24","10.7.61.0/24","10.7.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.7.80.0/24","10.7.81.0/24","10.7.82.0/24"]
vpc_pn_core_servicedesk_subnets_cidrs = ["10.7.7.0/28","10.7.7.16/28","10.7.7.32/28"]


