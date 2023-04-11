
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

