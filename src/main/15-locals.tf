locals {

  Core_SubnetsIds = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          module.vpc_pn_core.intra_subnets[idx] 
            if contains( var.vpc_pn_core_core_subnets_cidrs, cidr)
    ]
  
  Core_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_core_subnets_cidrs, cidr)
    ]
  

  Core_EgressSubnetsIds = [
      for idx, cidr in module.vpc_pn_core.private_subnets_cidr_blocks:
          module.vpc_pn_core.private_subnets[idx] 
            if contains( var.vpc_pn_core_core_egress_subnets_cidrs, cidr)
    ]
  
  Core_EgressSubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.private_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_core_egress_subnets_cidrs, cidr)
    ]
  

  Core_NlbWeb_SubnetsIds = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          module.vpc_pn_core.intra_subnets[idx] 
            if contains( var.vpc_pn_core_api_gw_subnets_cidrs, cidr)
    ]
  
  Core_NlbWeb_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_api_gw_subnets_cidrs, cidr)
    ]
  

  Core_NlbRadd_SubnetsIds = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          module.vpc_pn_core.intra_subnets[idx] 
            if contains( var.vpc_pn_core_radd_subnets_cidrs, cidr)
    ]
  
  Core_NlbRadd_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_radd_subnets_cidrs, cidr)
    ]

  Core_NlbServiceDesk_SubnetsIds = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          module.vpc_pn_core.intra_subnets[idx] 
            if contains( var.vpc_pn_core_servicedesk_subnets_cidrs, cidr)
    ]
  
  Core_NlbServiceDesk_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_servicedesk_subnets_cidrs, cidr)
    ]  


  Core_OpenSearch_SubnetsIds = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          module.vpc_pn_core.intra_subnets[idx] 
            if contains( var.vpc_pn_core_opensearch_subnets_cidrs, cidr)
    ]
  
  Core_OpenSearch_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_opensearch_subnets_cidrs, cidr)
    ]
  

  Core_ToConfinfo_SubnetsIds = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          module.vpc_pn_core.intra_subnets[idx] 
            if contains( var.vpc_pn_core_to_confinfo_subnets_cidrs, cidr)
    ]
  
  Core_ToConfinfo_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_core.intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_core_to_confinfo_subnets_cidrs, cidr)
    ]
  
  Core_CorsAllowedDomains_base = [
      for idx, cdn in var.cdn_domains:
          "https://${cdn}.${var.dns_zone}"
   ]
  
  Core_CorsAllowedDomains = (var.pn_cors_addictive_sources != "" ) ? flatten([ var.pn_cors_addictive_sources , local.Core_CorsAllowedDomains_base]) : local.Core_CorsAllowedDomains_base


  Core_CdnDomains = [
      for idx, cdn in var.cdn_domains:
          "${cdn}.${var.dns_zone}"
   ]
  
  VPN_SubnetsCidrs = var.vpc_pn_vpn_is_enabled ? [
      for idx, cidr in module.vpc_pn_vpn["enabled"].intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_vpn_pvt_subnets_cidrs, cidr)
    ] : []
  
  VPN_Subnet_IDs = var.vpc_pn_vpn_is_enabled ? [
    for idx, cidr in module.vpc_pn_vpn["enabled"].intra_subnets_cidr_blocks :
      module.vpc_pn_vpn["enabled"].intra_subnets[idx]
      if contains(var.vpc_pn_vpn_pvt_subnets_cidrs, cidr)
  ] : []
  
  VPC_IP_No_CIDR = var.vpc_pn_vpn_is_enabled ? (split("/", module.vpc_pn_vpn["enabled"].vpc_cidr_block))[0] : ""
  
  VPC_DNS_Server =  var.vpc_pn_vpn_is_enabled ? (replace(local.VPC_IP_No_CIDR, "/.0$/", ".2")) : ""
  
  VPN_Services_SubnetsCidrs = var.vpc_pn_vpn_is_enabled ? [
      for idx, cidr in module.vpc_pn_vpn["enabled"].intra_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_vpn_aws_subnets_cidrs, cidr)
    ] : []
  
  VPN_Services_Subnet_IDs = var.vpc_pn_vpn_is_enabled ? [
    for idx, cidr in module.vpc_pn_vpn["enabled"].intra_subnets_cidr_blocks :
      module.vpc_pn_vpn["enabled"].intra_subnets[idx]
      if contains(var.vpc_pn_vpn_aws_subnets_cidrs, cidr)
  ] : []
  
  iam_managed_policy_attachments = {
    for tuple in flatten([
      for role_name, config in var.iam_ext_roles_config : [
        for policy_name in config.managed_policies : {
          key         = "${role_name}.${policy_name}"
          role_name   = role_name
          policy_name = policy_name
        }
      ]
    ]) : tuple.key => {
      role_name   = tuple.role_name
      policy_name = tuple.policy_name
    }
  }

  iam_inline_policy_attachments = {
    for tuple in flatten([
      for role_name, config in var.iam_ext_roles_config : [
        for inline_policy in lookup(config, "inline_policies", []) : {
          key         = "${role_name}.${inline_policy.name}"
          role_name   = role_name
          policy_name = inline_policy.name
          policy_file = "./policies/${inline_policy.name}.json"
        }
      ]
    ]) : tuple.key => {
      role_name   = tuple.role_name
      policy_name = tuple.policy_name
      policy_file = tuple.policy_file
    }
  }

  pn_zone_dns_records_map = {
    for record in var.pn_zone_dns_records : "${record.name}_${record.type}" => record
  }

  pagopa_zone_dns_records_map = {
    for record in var.pagopa_zone_dns_records : "${record.name}_${record.type}" => record
  }
}