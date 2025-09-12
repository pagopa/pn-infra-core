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
  
  Simulator_VPN_SubnetsCidrs = [
      for idx, cidr in module.vpc_pn_simulator["enabled"].private_subnets_cidr_blocks:
          cidr
            if contains( var.vpc_pn_simulator_private_subnets_cidr, cidr)
    ]
  
}
