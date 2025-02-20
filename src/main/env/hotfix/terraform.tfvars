
environment = "hotfix"
how_many_az = 3
dns_zone = "hotfix.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
cdn_domains = ["selfcare","cittadini","login","imprese","www","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
  
pn_core_aws_account_id = "207905393513"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-028e57d02dfd2ba53"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-09f2a367f89a819f3"
pn_cors_addictive_sources = ""
pn_auth_fleet_addictive_allowed_issuer = "https://uat.selfcare.pagopa.it,https://pnpg.uat.selfcare.pagopa.it"
pn_cost_anomaly_detection_email = "pn-irt-team@pagopa.it"
pn_cost_anomaly_detection_threshold = "10"
generate_landing_multi_domain_cdn_cert = true
landing_cdn_allowed_internal_zones = ["hotfix.notifichedigitali.it"]
landing_cdn_allowed_external_zones = ["notifichedigitali.pagopa.it"]
landing_multi_domain_cert_domains = ["showcase.hotfix.notifichedigitali.it","www.hotfix.notifichedigitali.it","hotfix.notifichedigitali.pagopa.it","www.hotfix.notifichedigitali.pagopa.it"]
landing_single_domain = "www"
pn_confinfo_aws_account_id = "839620963891"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-839620963891"
pn_radd_aws_account_id = "515674411184"
pn_servicedesk_aws_account_id = "533236674075"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.15.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.15.70.0/24","10.15.71.0/24","10.15.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.15.40.0/24","10.15.41.0/24","10.15.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (hotfix) AZ 0","PN Core - PnCore Egress Subnet (hotfix) AZ 1","PN Core - PnCore Egress Subnet (hotfix) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.15.1.0/28","10.15.1.16/28","10.15.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (hotfix) AZ 0","PN Core - Public Subnet (hotfix) AZ 1","PN Core - Public Subnet (hotfix) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.15.3.0/28","10.15.3.16/28","10.15.3.32/28","10.15.5.0/28","10.15.5.16/28","10.15.5.32/28","10.15.20.0/24","10.15.21.0/24","10.15.22.0/24","10.15.60.0/24","10.15.61.0/24","10.15.62.0/24","10.15.70.0/24","10.15.71.0/24","10.15.72.0/24","10.15.80.0/24","10.15.81.0/24","10.15.82.0/24","10.15.7.0/28","10.15.7.16/28","10.15.7.32/28"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (hotfix) AZ 0","PN Core - API-GW VpcLink Subnet (hotfix) AZ 1","PN Core - API-GW VpcLink Subnet (hotfix) AZ 2","PN Core - RADD Ingress Subnet (hotfix) AZ 0","PN Core - RADD Ingress Subnet (hotfix) AZ 1","PN Core - RADD Ingress Subnet (hotfix) AZ 2","PN Core - PnCore Subnet (hotfix) AZ 0","PN Core - PnCore Subnet (hotfix) AZ 1","PN Core - PnCore Subnet (hotfix) AZ 2","PN Core - To Confidential Info Subnet (hotfix) AZ 0","PN Core - To Confidential Info Subnet (hotfix) AZ 1","PN Core - To Confidential Info Subnet (hotfix) AZ 2","PN Core - AWS Services Subnet (hotfix) AZ 0","PN Core - AWS Services Subnet (hotfix) AZ 1","PN Core - AWS Services Subnet (hotfix) AZ 2","PN Core - OpenSearch Subnet (hotfix) AZ 0","PN Core - OpenSearch Subnet (hotfix) AZ 1","PN Core - OpenSearch Subnet (hotfix) AZ 2","PN Core - Service Desk Ingress Subnet (hotfix) AZ 0","PN Core - Service Desk Ingress Subnet (hotfix) AZ 1","PN Core - Service Desk Ingress Subnet (hotfix) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.15.3.0/28","10.15.3.16/28","10.15.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.15.5.0/28","10.15.5.16/28","10.15.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.15.20.0/24","10.15.21.0/24","10.15.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.15.40.0/24","10.15.41.0/24","10.15.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.15.60.0/24","10.15.61.0/24","10.15.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.15.80.0/24","10.15.81.0/24","10.15.82.0/24"]
vpc_pn_core_servicedesk_subnets_cidrs = ["10.15.7.0/28","10.15.7.16/28","10.15.7.32/28"]


