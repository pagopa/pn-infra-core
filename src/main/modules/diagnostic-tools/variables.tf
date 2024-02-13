variable "function_name" {
  type        = string
  default     = "diagnostic-data-proxy"
  description = "The name of the Lambda"
}

variable "s3_code_bucket" {
  type        = string
  default     = null
  description = "The name of the S3 bucket from which to load the Lambda code. Required if filename is not specified"
}

variable "s3_code_key" {
  type        = string
  default     = null
  description = "The S3 key of the Lambda code ZIP file. Required if filename is not specified"
}

variable "filename" {
  type        = string
  default     = null
  description = "Local path to the Lambda code ZIP file. If not specified, s3_bucket and s3_key must be used"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "The memory of the lambda."
}

variable "aws_region" {
  type        = string
  description = "AWS region to create resources"
}

variable "pn_core_aws_account_id" {
  type        = string
  description = "AWS pn-core account id"
}

variable "handler" {
  type        = string
  default     = "index.handler"
  description = "Handler Lambda"
}

variable "runtime" {
  type        = string
  description = "NodeJs runtime"
}

variable "diagnostic_assumerole_arn" {
  type        = string
  description = "Arn of role for calling diagnostic Lambda"
}

variable "diagnostic_data_proxy_function_name" {
  type        = string
  description = "diagnostic_data_proxy function name"
}

variable "diagnostic_data_proxy_lambda_region" {
  type        = string
  description = "AWS region of diagnostic_data_proxy Lambda"
}

variable "pn_data_vault_base_url" {
  type        = string
  description = "Base url of pn-datavault service"
}

variable "vpc_id" {
  type        = string
}

variable "vpc_subnet_ids" {
  type        = list(string)
}