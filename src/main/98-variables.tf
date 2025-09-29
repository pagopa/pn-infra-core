variable "aws_region" {
  type        = string
  description = "AWS region to create resources. Default Milan"
  default     = "eu-south-1"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "how_many_az" {
  type        = number
  default     = 3
  description = "How many Availability Zone we have to use"
}

variable "pn_core_aws_account_id" {
  type        = string
  description = "pn-core current environment AWS Account id"
}

variable "pn_confinfo_aws_account_id" {
  type        = string
  description = "pn-confidential current environment AWS Account id"
}

variable "pn_radd_aws_account_id" {
  type        = string
  description = "pn-radd current environment AWS Account id"
}

variable "pn_servicedesk_aws_account_id" {
  type        = string
  description = "pn-servicedesk current environment AWS Account id"
}

variable "pn_cicd_aws_account_id" {
  description = "Cicd AWS Account id"
  type        = string
}

variable "pn_dns_extra_cname_entries" {
  type        = string
  default     = "{}"
  description = "Additional CNAME DNS entries"
}

variable "pagopa_dns_extra_cname_entries" {
  type        = string
  default     = "{}"
  description = "Additional CNAME DNS entries for pagopa domain"
}

variable "pn_zone_dns_records" {
  type = list(object({
    name  = string
    type  = string
    ttl   = number
    value = list(string)
  }))
  description = "List of DNS records to create in the PN route53 zone. Each record is an object with name, type, ttl, and value."
  default     = []
}

variable "pagopa_zone_dns_records" {
  type = list(object({
    name  = string
    type  = string
    ttl   = number
    value = list(string)
  }))
  description = "List of DNS records to createin the 'notifichedigitali.pagopa.it' delegated zone. Each record is an object with name, type, ttl, and value."
  default     = []
}

variable "pn_core_to_data_vault_vpcse" {
  type        = string
  description = "Confinfo VPC Service endpoint exposing DataVault services"
}

variable "pn_core_to_extch_safestorage_vpcse" {
  type        = string
  description = "Confinfo VPC Service endpoint exposing SafeStorage and External Channel services"
}




variable "dns_zone" {
  type        = string
  description = "Dns zone used for the environment"
}

variable "pagopa_zone_delegation_enabled" {
  type        = bool
  description = "If true, enables pagopa zone management (prod only)."
  default     = false
}

variable "pagopa_dns_zone" {
  type        = string
  default     = ""
  description = "Pagopa dns zone used for the environment"
}

variable "api_domains" {
  type        = set(string)
  description = "List of regional api endpoint, entry in the dns zone. This parameter is used for ACM certificate creation"
}

variable "cdn_domains" {
  type        = set(string)
  description = "List of CDN domains"
}

variable "apigw_custom_domains" {
  type        = set(string)
  description = "List of API-GW custom domains"
}


variable "dns_record_ttl" {
  type        = number
  description = "Dns record ttl (in sec)"
  default     = 60 # 1 minute
}

variable "landing_single_domain" {
  type        = string
  default     = "www"
  description = "name of the label related to the primary domain of showcase site, relevant in the single-domain certificate setup"
}

variable "generate_landing_multi_domain_cdn_cert" {
  type        = bool
  description = "If false, module will not create certificate and related resources."
  default     = false
}

variable "enable_landing_cdn_redirect_function" {
  type        = bool
  description = "If true, enable the creation of the cloudfront fucntion for redirect in the web-landing-cdn cloudformation stack."
  default     = false
}

variable "landing_cdn_allowed_internal_zones" {
  type        = list(string)
  description = "List of allowed internal Route53 zones for pn-showcase landing page multi domain certificate"
  default     = []
}

variable "landing_cdn_allowed_external_zones" {
  type        = list(string)
  description = "External zones for pn-showcase landing page multi domain certificate, if set, the validation record for the domains belongign will NOT be auto-created and validation will not be awaited. Output includes manual record details."
  default     = []
}

variable "landing_multi_domain_cert_domains" {
  type        = list(string)
  description = "List of domains for multi-domain certificate. The first is primary, others are SAN."
  default     = []
}



variable "vpc_pn_core_aws_services_interface_endpoints_subnets_cidr" {
  type        = list(string)
  description = "AWS services interfaces endpoints list of cidr."
}

variable "vpc_pn_core_name" {
  type        = string
  description = "Name of the PN Core VPC"
}

variable "vpc_pn_core_primary_cidr" {
  type        = string
  description = "Primary CIDR of the PN Core VPC"
}


variable "vpc_pn_core_private_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
}
variable "vpc_pn_core_private_subnets_names" {
  type        = list(string)
  description = "Private subnets list of names."
}

variable "vpc_pn_core_public_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
}
variable "vpc_pn_core_public_subnets_names" {
  type        = list(string)
  description = "Private subnets list of names."
}

variable "vpc_pn_core_internal_subnets_cidr" {
  type        = list(string)
  description = "Internal subnets list of cidr"
}
variable "vpc_pn_core_internal_subnets_names" {
  type        = list(string)
  description = "Internal subnets list of names"
}

variable "vpc_endpoints_pn_core" {
  type        = list(string)
  description = "Endpoint List"
}


variable "vpc_pn_core_core_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of core subnets in VPC pn-core"
}

variable "vpc_pn_core_core_egress_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of core_egres subnets in VPC pn-core"
}

variable "vpc_pn_core_api_gw_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of API-GW ingress NLB subnets in VPC pn-core"
}

variable "vpc_pn_core_radd_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of RADD ingress NLB subnets in VPC pn-core"
}


variable "vpc_pn_core_servicedesk_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of Service Desk ingress NLB subnets in VPC pn-core"
}

variable "vpc_pn_core_opensearch_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of OpenSearch subnets in VPC pn-core"
}

variable "vpc_pn_core_to_confinfo_subnets_cidrs" {
  type        = list(string)
  description = "Cidr list of subnets containing connectivity to confinfo account in VPC pn-core"
}

variable "pn_safestorage_data_bucket_name" {
  type        = string
  description = "Nome del bucket in cui il FE dovrà caricare gli allegati delle notifiche"
}

variable "pn_cors_addictive_sources" {
  type        = string
  description = "Elementi aggiuntivi da aggiungere agli allowed cors"
}

variable "pn_auth_fleet_addictive_allowed_issuer" {
  type        = string
  description = "Allowed issuer for PN authentication sources"
}

variable "pn_cost_anomaly_detection_email" {
  type        = string
  description = "pn-core cost anomaly detection email"
}

variable "pn_cost_anomaly_detection_threshold" {
  type        = string
  description = "pn-core cost anomaly detection threshold (percentage)"
}

variable "vpn_saml_metadata_path" {
  description = "Path to the SAML metadata XML file. Used when federated authentication for VPN is enabled"
  type        = string
  default     = null
}

variable "vpc_pn_vpn_name" {
  type        = string
  description = "Name of the PN Simulator VPC"
}

variable "pn_vpn_cidr" {
  type        = string
  description = "CIDR of the PN Simulator VPN"
}

variable "vpc_pn_vpn_primary_cidr" {
  type        = string
  description = "Primary CIDR of the PN Simulator VPC"
}

variable "vpc_pn_vpn_private_subnets_cidr" {
  type        = list(string)
  description = "Private subnets list of cidr."
}
variable "vpc_pn_vpn_private_subnets_names" {
  type        = list(string)
  description = "Private subnets list of names."
}

variable "vpc_pn_vpn_public_subnets_cidr" {
  type        = list(string)
  description = "Public subnets list of cidr."
}
variable "vpc_pn_vpn_public_subnets_names" {
  type        = list(string)
  description = "Public subnets list of names."
}

variable "vpc_pn_vpn_internal_subnets_cidr" {
  type        = list(string)
  description = "Internal subnets list of cidr"
}
variable "vpc_pn_vpn_internal_subnets_names" {
  type        = list(string)
  description = "Internal subnets list of names"
}

variable "vpc_pn_vpn_pvt_subnets_cidrs" {
  type        = list(string)
  description = "Internal subnets list of cidr"
}

variable "vpc_pn_vpn_aws_subnets_cidrs" {
  type        = list(string)
  description = "Internal subnets list of cidr"
}


variable "vpc_pn_vpn_is_enabled" {
  type        = bool
  description = "If true, enable the creation of vpc for vpn."
  default     = false
}

variable "vpc_pn_vpn_aws_services_interface_endpoints_subnets_cidr" {
  type        = list(string)
  description = "AWS services interfaces endpoints list of cidr."
}

variable "vpc_endpoints_pn_vpn" {
  type        = list(string)
  description = "Endpoint List"
}

variable "iam_ext_roles_config" {
  type = map(object({
    managed_policies = list(string)
    inline_policies  = optional(list(object({
      name = string
    })), [])
  }))
}
