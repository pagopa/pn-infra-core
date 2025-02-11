variable "domains" {
  type        = list(string)
  description = "List of domains for multidomain certificate, the first domain is the primary domain, the other are SANs"
  validation {
    condition     = length(var.domains) > 0
    error_message = "At least one domain must be provided"
  }
  validation {
    condition = alltrue([
      for domain in var.domains :
      can(regex("^(\\*\\.)?[a-z0-9][a-z0-9-]*(\\.[a-z0-9][a-z0-9-]*)*$", domain))  #wildcard support
    ])
    error_message = "Invalid domain format, domains must be lowercase and contain only letters, numbers, hyphens and dots"
  }
}

variable "allowed_internal_zones" {
  type        = list(string)
  description = "List of allowed internal Route53 zone names"
  default     = []
}

variable "allowed_external_zones" {
  type        = list(string)
  description = "List of external, cross-account zone names, for these domains manual validation record details are provided via output"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply to certificate"
  default     = {}
}
