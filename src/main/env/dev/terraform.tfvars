
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
vpn_saml_metadata_path = "./assets/saml-metadata/pn-vpn-saml-dev.xml"
vpc_pn_vpn_is_enabled = true
pn_vpn_cidr = "10.100.0.0/22"
iam_ext_roles_config = {"SendExtAdmin":{"managed_policies":["AdministratorAccess"]},"SendExtReadOnly":{"managed_policies":["ReadOnlyAccess","AWSCloudShellFullAccess"],"inline_policies":[{"name":"KmsDecrypt"},{"name":"AthenaRead"}]},"SendExtPowerUser":{"managed_policies":["ReadOnlyAccess","AmazonSSMFullAccess","SecretsManagerReadWrite","AWSCodeBuildDeveloperAccess","AmazonDynamoDBFullAccess","AWSCloudShellFullAccess"],"inline_policies":[{"name":"KmsDecrypt"},{"name":"QaPolicy"},{"name":"AthenaRead"}]}}
pn_zone_dns_records = [{"name":"4nrumbeqx2zgef22hosjkwuxdfubess3._domainkey.dev.notifichedigitali.it","type":"CNAME","ttl":300,"value":["4nrumbeqx2zgef22hosjkwuxdfubess3.dkim.eu-south-1.amazonses.com"]},{"name":"nhw5hdrtn5bh3paxodxhnwzc5qkue33d._domainkey.dev.notifichedigitali.it","type":"CNAME","ttl":300,"value":["nhw5hdrtn5bh3paxodxhnwzc5qkue33d.dkim.eu-south-1.amazonses.com"]},{"name":"ufdxabswg6emrc3ohqqtfdrrdmdiaoa4._domainkey.dev.notifichedigitali.it","type":"CNAME","ttl":300,"value":["ufdxabswg6emrc3ohqqtfdrrdmdiaoa4.dkim.eu-south-1.amazonses.com"]},{"name":"mail.dev.notifichedigitali.it","type":"MX","ttl":300,"value":["10 feedback-smtp.eu-south-1.amazonses.com"]},{"name":"mail.dev.notifichedigitali.it","type":"TXT","ttl":300,"value":["v=spf1 include:amazonses.com ~all"]},{"name":"test.dev.notifichedigitali.it","type":"TXT","ttl":300,"value":["Test entry for dev.notifichedigitali.it zone"]}]
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





vpc_pn_vpn_name = "PN VPN"
vpc_pn_vpn_primary_cidr = "10.20.0.0/16"
vpc_pn_vpn_aws_services_interface_endpoints_subnets_cidr = ["10.20.70.0/24","10.20.71.0/24","10.20.72.0/24"]
vpc_endpoints_pn_vpn = ["ecr.api","ecr.dkr","lambda","logs","monitoring","events","ecs","ecs-agent","ecs-telemetry","secretsmanager"]

vpc_pn_vpn_private_subnets_cidr = []
vpc_pn_vpn_private_subnets_names = []
vpc_pn_vpn_public_subnets_cidr = []
vpc_pn_vpn_public_subnets_names = []
vpc_pn_vpn_internal_subnets_cidr = ["10.20.70.0/24","10.20.71.0/24","10.20.72.0/24","10.20.3.0/24","10.20.4.0/24","10.20.5.0/24"]
vpc_pn_vpn_internal_subnets_names = ["PN VPN - AWS Services Subnet (dev) AZ 0","PN VPN - AWS Services Subnet (dev) AZ 1","PN VPN - AWS Services Subnet (dev) AZ 2","PN VPN - private Subnet (dev) AZ 0","PN VPN - private Subnet (dev) AZ 1","PN VPN - private Subnet (dev) AZ 2"]

vpc_pn_vpn_aws_subnets_cidrs = ["10.20.70.0/24","10.20.71.0/24","10.20.72.0/24"]
vpc_pn_vpn_pvt_subnets_cidrs = ["10.20.3.0/24","10.20.4.0/24","10.20.5.0/24"]


