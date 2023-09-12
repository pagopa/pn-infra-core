
output "Core_VpcId" {
  value = module.vpc_pn_core.vpc_id
  description = "Id della VPC contenete i microservizi di PN che trattano informazioni Personali"
}

output "Core_VpcCidr" {
  value = var.vpc_pn_core_primary_cidr
  description = "CIDR della VPC contenete i microservizi di PN che trattano informazioni Personali"
}

output "Core_VpcEndpointsRequired" { 
  value       = "false"
  description = "AWS services endpoints already created"
}


output "Core_VpcSubnets" {
  value = local.Core_SubnetsIds
}

output "Core_VpcSubnetsCidrs" {
  value = local.Core_SubnetsCidrs
}

output "Core_VpcEgressSubnetsIds" {
  value = local.Core_EgressSubnetsIds
}

output "Core_VpcEgressSubnetsCidrs" {
  value = local.Core_EgressSubnetsCidrs
}

output "Core_VpcOpensearchSubnetsIds" {
  value = local.Core_OpenSearch_SubnetsIds
}

output "Core_VpcOpensearchSubnetsCidrs" {
  value = local.Core_OpenSearch_SubnetsCidrs
}


output "Core_ApplicationLoadBalancerArn" {
  value = aws_lb.pn_core_ecs_alb.arn
  description = "ECS cluster Application Load Balancer ARN, attach microservice listeners here"
}

output "Core_ApplicationLoadBalancerMetricsDimensionName" {
  value = replace( aws_lb.pn_core_ecs_alb.arn, "/.*:[0-9]{12}:loadbalancer.app.(.*)/", "app/$1")
  description = "ECS cluster Application Load Balancer name used for metrics"
}


output "Core_ApplicationLoadBalancerAwsDns" {
  value = aws_lb.pn_core_ecs_alb.dns_name 
  description = "ECS cluster Application Load Balancer AWS released DNS, can be used to call microservices"
}

output "Core_ApplicationLoadBalancerAwsDnsZoneId" {
  value = aws_lb.pn_core_ecs_alb.zone_id 
  description = "ECS cluster Application Load Balancer AWS hosted Zone, usefull for aliases"
}

output "Core_ApplicationLoadBalancerListenerArn" {
  value = aws_lb_listener.pn_core_ecs_alb_8080.arn
  description = "ECS cluster Application Load Balancer Listener ARN, attach here new microservice routing rule"
}


output "Core_WebappSecurityGroupId" {
  value = aws_security_group.vpc_pn_core__secgrp_webapp.id
  description = "WebApp security group id"
}

output "Core_WebappSecurityGroupArn" {
  value = aws_security_group.vpc_pn_core__secgrp_webapp.arn
  description = "WebApp security group ARN"
}

output "Core_NetworkLoadBalancerLink" {
  value = aws_api_gateway_vpc_link.pn_core_api_gw_vpc_lik.id
}

output "Core_CustomDomainsRequired" {
  value = "false"
  description = "Cloudformation neet to build API-GW custom domain"
}


output "Core_SafeStorageAccountId" {
  value = var.pn_confinfo_aws_account_id
  description = "Safe Storage will be deployed into confinfo account"
}

output "Core_ConfidentialInfoAccountId" {
  value = var.pn_confinfo_aws_account_id
  description = "Confidential Information account id"
}

output "Core_HelpdeskAccountId" {
  value = var.pn_core_aws_account_id
  description = "Helpdesk will be merged into pn-core"
}

output "Core_SandboxSafeStorageBaseUrl" {
  value = "http://${aws_vpc_endpoint.to_safestorage_extch.dns_entry[0].dns_name}:8080/"
  description = "EndpointUrl to reach SafeStorage"
}



output "Core_ApiDnsName" {
  value = "api.${var.dns_zone}"
}

output "Core_SelcpgApiDnsName" {
  value = "api-selcpg.${var.dns_zone}"
}

output "Core_CNApiDnsName" {
  value = "api.cn.${var.dns_zone}"
}

output "Core_WebApiDnsName" {
  value = "webapi.${var.dns_zone}"
}

output "Core_IoApiDnsName" {
  value = "api-io.${var.dns_zone}"
}

output "Core_RaddApiDnsName" {
  value = "api.radd.${var.dns_zone}"
}

output "Core_BoApiDnsName" {
  value = "api.bo.${var.dns_zone}"
}


output "Core_CdnZoneId" {
  value = local.account_root_dns_zone_id
}

output "Core_PortalePaCertificateArn" {
  value = module.acm_cdn["selfcare"].acm_certificate_arn
}

output "Core_PortalePfCertificateArn" {
  value = module.acm_cdn["cittadini"].acm_certificate_arn
}

output "Core_PortalePfLoginCertificateArn" {
  value = module.acm_cdn["login"].acm_certificate_arn
}

output "Core_LandingCertificateArn" {
  value = module.acm_cdn["www"].acm_certificate_arn
}

output "Core_PortalePgCertificateArn" {
  value = module.acm_cdn["imprese"].acm_certificate_arn
}

output "Core_PortaleStatusCertificateArn" {
  value = module.acm_cdn["status"].acm_certificate_arn
}

output "Core_PortaleHelpdeskCertificateArn" {
  value = module.acm_cdn["helpdesk"].acm_certificate_arn
}


output "Core_PortalePaDomain" {
  value = "selfcare.${var.dns_zone}"
}

output "Core_PortalePfDomain" {
  value = "cittadini.${var.dns_zone}"
}

output "Core_PortalePfLoginDomain" {
  value = "login.${var.dns_zone}"
}

output "Core_LandingDomain" {
  value = "www.${var.dns_zone}"
}

output "Core_PortalePgDomain" {
  value = "imprese.${var.dns_zone}"
}

output "Core_PortaleStatusDomain" {
  value = "status.${var.dns_zone}"
}

output "Core_PortaleHelpdeskDomain" {
  value = "helpdesk.${var.dns_zone}"
}


output "Core_ReactAppUrlApi" {
  value = "https://webapi.${var.dns_zone}/ https://${var.pn_safestorage_data_bucket_name}.s3.${local.region}.amazonaws.com/"
}

output "Core_CorsAllowedDomains" {
  value = join(", ", local.Core_CorsAllowedDomains)
}


output "Core_TokenExchangeLambdaEnvironmentIssuer" {
  value = "https://webapi.${var.dns_zone}"
}

output "Core_TokenExchangeLambdaEnvironmentAllowedIssuer" {
  value = "https://hub-login.spid.${var.dns_zone},${var.pn_auth_fleet_addictive_allowed_issuer}"
}

output "Core_TokenExchangeLambdaEnvironmentAllowedOrigin" {
  value = join(",", local.Core_CorsAllowedDomains)
}

output "Core_TokenExchangeLambdaEnvironmentAcceptedAudience" {
  value = join(",", local.Core_CdnDomains)
}

output "Core_TokenExchangeLambdaEnvironmentAudience" {
  value = "webapi.${var.dns_zone}"
}

output "Core_TokenExchangeLambdaEnvironmentJwksMapping" {
  value = jsonencode({ })
}

output "Core_ApikeyAuthorizerV2PDNDAudience" {
  value = "https://api.${var.dns_zone}"
}

output "Core_HubLoginDomain" {
  value = "hub-login.spid.${var.dns_zone}"
}

