
environment = "dev"
how_many_az = 3
dns_zone = "dev.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
cdn_domains = ["selfcare","cittadini","login","imprese","www","showcase","maps","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
  
pn_core_aws_account_id = "830192246553"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-05e7543f3ead0c903"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-07d53855bfe7d3c4a"
pn_cors_addictive_sources = "http://localhost:8090,https://pg-webapp.fe-prototype.dev.notifichedigitali.it,https://pa-webapp.fe-prototype.dev.notifichedigitali.it,https://pf-webapp.fe-prototype.dev.notifichedigitali.it"
pn_auth_fleet_addictive_allowed_issuer = "https://dev.selfcare.pagopa.it,https://uat.selfcare.pagopa.it,https://pnpg.dev.selfcare.pagopa.it,https://pnpg.uat.selfcare.pagopa.it"
pn_cost_anomaly_detection_email = "pn-irt-team@pagopa.it"
pn_cost_anomaly_detection_threshold = "10"
pagopa_zone_delegation_enabled = false
generate_landing_multi_domain_cdn_cert = false
enable_landing_cdn_redirect_function = false
landing_cdn_allowed_internal_zones = ["dev.notifichedigitali.it"]
landing_cdn_allowed_external_zones = ["notifichedigitali.pagopa.it"]
landing_multi_domain_cert_domains = ["showcase.dev.notifichedigitali.it","www.dev.notifichedigitali.it","dev.notifichedigitali.pagopa.it","www.dev.notifichedigitali.pagopa.it"]
landing_single_domain = "showcase"
external_roles_config = {"SendExtAdmin":{"managed_policies":["AdministratorAccess"]},"SendExtReadOnly":{"managed_policies":["ReadOnlyAccess"],"inline_policies":[{"name":"Kms_Decrypt.json","file":"/src/main/policies/Kms_Decrypt.json"}]},"SendExtPowerUser":{"managed_policies":["ReadOnlyAccess","AmazonSSMFullAccess","SecretsManagerReadWrite","AWSCodeBuildDeveloperAccess","AmazonDynamoDBFullAccess","AWSLambda_FullAccess"],"inline_policies":[{"name":"Kms_Decrypt.json","file":"/src/main/policies/Kms_Decrypt.json"},{"name":"pn-CloudformationUpload.json","file":"/src/main/policies/pn-CloudformationUpload.json"}]}}
pn_confinfo_aws_account_id = "089813480515"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-089813480515"
pn_radd_aws_account_id = "830192246553"
pn_servicedesk_aws_account_id = "911845998067"
pn_cicd_aws_account_id = "911845998067"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.1.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.1.70.0/24","10.1.71.0/24","10.1.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","xray"]

vpc_pn_core_private_subnets_cidr = ["10.1.40.0/24","10.1.41.0/24","10.1.42.0/24"]
vpc_pn_core_private_subnets_names = ["PN Core - PnCore Egress Subnet (dev) AZ 0","PN Core - PnCore Egress Subnet (dev) AZ 1","PN Core - PnCore Egress Subnet (dev) AZ 2"]
vpc_pn_core_public_subnets_cidr = ["10.1.1.0/28","10.1.1.16/28","10.1.1.32/28"]
vpc_pn_core_public_subnets_names = ["PN Core - Public Subnet (dev) AZ 0","PN Core - Public Subnet (dev) AZ 1","PN Core - Public Subnet (dev) AZ 2"]
vpc_pn_core_internal_subnets_cidr = ["10.1.3.0/28","10.1.3.16/28","10.1.3.32/28","10.1.5.0/28","10.1.5.16/28","10.1.5.32/28","10.1.20.0/24","10.1.21.0/24","10.1.22.0/24","10.1.60.0/24","10.1.61.0/24","10.1.62.0/24","10.1.70.0/24","10.1.71.0/24","10.1.72.0/24","10.1.80.0/24","10.1.81.0/24","10.1.82.0/24","10.1.7.0/28","10.1.7.16/28","10.1.7.32/28"]
vpc_pn_core_internal_subnets_names = ["PN Core - API-GW VpcLink Subnet (dev) AZ 0","PN Core - API-GW VpcLink Subnet (dev) AZ 1","PN Core - API-GW VpcLink Subnet (dev) AZ 2","PN Core - RADD Ingress Subnet (dev) AZ 0","PN Core - RADD Ingress Subnet (dev) AZ 1","PN Core - RADD Ingress Subnet (dev) AZ 2","PN Core - PnCore Subnet (dev) AZ 0","PN Core - PnCore Subnet (dev) AZ 1","PN Core - PnCore Subnet (dev) AZ 2","PN Core - To Confidential Info Subnet (dev) AZ 0","PN Core - To Confidential Info Subnet (dev) AZ 1","PN Core - To Confidential Info Subnet (dev) AZ 2","PN Core - AWS Services Subnet (dev) AZ 0","PN Core - AWS Services Subnet (dev) AZ 1","PN Core - AWS Services Subnet (dev) AZ 2","PN Core - OpenSearch Subnet (dev) AZ 0","PN Core - OpenSearch Subnet (dev) AZ 1","PN Core - OpenSearch Subnet (dev) AZ 2","PN Core - Service Desk Ingress Subnet (dev) AZ 0","PN Core - Service Desk Ingress Subnet (dev) AZ 1","PN Core - Service Desk Ingress Subnet (dev) AZ 2"]

vpc_pn_core_api_gw_subnets_cidrs = ["10.1.3.0/28","10.1.3.16/28","10.1.3.32/28"]
vpc_pn_core_radd_subnets_cidrs = ["10.1.5.0/28","10.1.5.16/28","10.1.5.32/28"]
vpc_pn_core_core_subnets_cidrs = ["10.1.20.0/24","10.1.21.0/24","10.1.22.0/24"]
vpc_pn_core_core_egress_subnets_cidrs = ["10.1.40.0/24","10.1.41.0/24","10.1.42.0/24"]
vpc_pn_core_to_confinfo_subnets_cidrs = ["10.1.60.0/24","10.1.61.0/24","10.1.62.0/24"]
vpc_pn_core_opensearch_subnets_cidrs = ["10.1.80.0/24","10.1.81.0/24","10.1.82.0/24"]
vpc_pn_core_servicedesk_subnets_cidrs = ["10.1.7.0/28","10.1.7.16/28","10.1.7.32/28"]


