# Default tags for the resources
locals {
  default_tags = {
    Project    = var.project_name
    Managed_by = "Terraform"
  }
}

# AWS provider
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = local.default_tags
  }
}

# Terraform backend to store state file
terraform {
  backend "s3" {
    bucket = "static-hosting-s3-backend"
    key    = "static-hosting"
    region = "us-east-1"
  }
}

# static hosting module
module "static-hosting" {
  source       = "./Modules/static-hosting"
  project_name = var.project_name
  domain_name  = var.domain_name
  acm_ssl_arn  = var.acm_ssl_arn
}
