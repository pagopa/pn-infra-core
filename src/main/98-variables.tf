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
