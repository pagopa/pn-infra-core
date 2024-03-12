terraform {
  required_version = "1.4.2"

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

provider "aws" {
  region = "eu-south-1"
  default_tags {
    tags = local.Core_Tags
  }
}
