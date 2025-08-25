variable "function_name" {
  type        = string
  default     = "diagnostic-deanonymize-notification"
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

variable "timeout" {
  type        = number
  default     = 15
  description = "The timeout of the lambda."
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

variable "alb_confidential_base_url" {
  type        = string
  description = "Base url of confidential ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "VPC subent ids"
}

variable "lambda_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for Lambda resource"
}