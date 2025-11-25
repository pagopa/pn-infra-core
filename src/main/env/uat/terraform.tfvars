
environment = "uat"
how_many_az = 3
dns_zone = "uat.notifichedigitali.it"
api_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
cdn_domains = ["selfcare","cittadini","login","imprese","www","showcase","maps","helpdesk"]
apigw_custom_domains = ["api","webapi","api-io","api.radd","api.bo","api-selcpg","api.cn","api.dest"]
  
pn_core_aws_account_id = "644374009812"
pn_core_to_data_vault_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-0137ff603c40224ec"
pn_core_to_extch_safestorage_vpcse = "com.amazonaws.vpce.eu-south-1.vpce-svc-0d3e538b0b0956de4"
pn_cors_addictive_sources = ""
pn_auth_fleet_addictive_allowed_issuer = "https://uat.selfcare.pagopa.it,https://pnpg.uat.selfcare.pagopa.it"
pn_cost_anomaly_detection_email = "pn-irt-team@pagopa.it"
pn_cost_anomaly_detection_threshold = "10"
generate_landing_multi_domain_cdn_cert = false
enable_landing_cdn_redirect_function = false
landing_cdn_allowed_internal_zones = ["uat.notifichedigitali.it"]
landing_cdn_allowed_external_zones = ["notifichedigitali.pagopa.it"]
landing_multi_domain_cert_domains = ["showcase.uat.notifichedigitali.it","www.uat.notifichedigitali.it","uat.notifichedigitali.pagopa.it","www.uat.notifichedigitali.pagopa.it"]
landing_single_domain = "showcase"
vpc_pn_vpn_is_enabled = false
vpn_is_enabled = false
iam_ext_roles_config = {"SendExtAdmin":{"managed_policies":["AdministratorAccess"]},"SendExtReadOnly":{"managed_policies":["ReadOnlyAccess","AWSCloudShellFullAccess"],"inline_policies":[{"name":"KmsDecrypt"},{"name":"AthenaRead"}]},"SendExtPowerUser":{"managed_policies":["ReadOnlyAccess","AmazonSSMFullAccess","SecretsManagerReadWrite","AWSCodeBuildDeveloperAccess","AmazonDynamoDBFullAccess","AWSCloudShellFullAccess"],"inline_policies":[{"name":"KmsDecrypt"},{"name":"QaPolicy"},{"name":"AthenaRead"}]}}
pn_zone_dns_records = [{"name":"3jpe7u42arpidhv22vcla7lpimzxoteg._domainkey.uat.notifichedigitali.it","type":"CNAME","ttl":300,"value":["3jpe7u42arpidhv22vcla7lpimzxoteg.dkim.eu-south-1.amazonses.com"]},{"name":"au3bauftu3ruoilbprqhs7hldnu3j25j._domainkey.uat.notifichedigitali.it","type":"CNAME","ttl":300,"value":["au3bauftu3ruoilbprqhs7hldnu3j25j.dkim.eu-south-1.amazonses.com."]},{"name":"vt4thzuk4irmgv5yu7colyhmcxcbiwww._domainkey.uat.notifichedigitali.it","type":"CNAME","ttl":300,"value":["vt4thzuk4irmgv5yu7colyhmcxcbiwww.dkim.eu-south-1.amazonses.com."]},{"name":"mail.uat.notifichedigitali.it","type":"MX","ttl":300,"value":["10 feedback-smtp.eu-south-1.amazonses.com."]},{"name":"mail.uat.notifichedigitali.it","type":"TXT","ttl":300,"value":["v=spf1 include:amazonses.com ~all"]}]
pn_confinfo_aws_account_id = "956319218727"
pn_safestorage_data_bucket_name = "pn-safestorage-eu-south-1-956319218727"
pn_radd_aws_account_id = "554102482368"
pn_servicedesk_aws_account_id = "533236674075"
pn_cicd_aws_account_id = "911845998067"


vpc_pn_core_name = "PN Core"
vpc_pn_core_primary_cidr = "10.7.0.0/16"
vpc_pn_core_aws_services_interface_endpoints_subnets_cidr = ["10.7.70.0/24","10.7.71.0/24","10.7.72.0/24"]
vpc_endpoints_pn_core = ["sqs","logs","sns","kms","kinesis-streams","elasticloadbalancing","events","ecr.api","ecr.dkr","ssmmessages","ssm","ec2messages","ecs-agent","ecs-telemetry","ecs","secretsmanager","monitoring","scheduler","xray"]

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





vpc_pn_vpn_name = "PN VPN"
vpc_pn_vpn_primary_cidr = "10.22.0.0/16"
vpc_pn_vpn_aws_services_interface_endpoints_subnets_cidr = ["10.22.70.0/24","10.22.71.0/24","10.22.72.0/24"]
vpc_endpoints_pn_vpn = ["ecr.api","ecr.dkr","lambda","logs","monitoring","events","ecs","ssm","ssmmessages","ecs-agent","ecs-telemetry","secretsmanager","scheduler"]

vpc_pn_vpn_private_subnets_cidr = []
vpc_pn_vpn_private_subnets_names = []
vpc_pn_vpn_public_subnets_cidr = []
vpc_pn_vpn_public_subnets_names = []
vpc_pn_vpn_internal_subnets_cidr = ["10.22.70.0/24","10.22.71.0/24","10.22.72.0/24","10.22.3.0/24","10.22.4.0/24","10.22.5.0/24"]
vpc_pn_vpn_internal_subnets_names = ["PN VPN - AWS Services Subnet (uat) AZ 0","PN VPN - AWS Services Subnet (uat) AZ 1","PN VPN - AWS Services Subnet (uat) AZ 2","PN VPN - private Subnet (uat) AZ 0","PN VPN - private Subnet (uat) AZ 1","PN VPN - private Subnet (uat) AZ 2"]

vpc_pn_vpn_aws_subnets_cidrs = ["10.22.70.0/24","10.22.71.0/24","10.22.72.0/24"]
vpc_pn_vpn_pvt_subnets_cidrs = ["10.22.3.0/24","10.22.4.0/24","10.22.5.0/24"]


