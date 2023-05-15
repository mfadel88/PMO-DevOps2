# Terraform Configuration Block
 
terraform {
  # Required Terraform Version
  required_version = "~> 1.3.0" # Symbol Allows 1.3.xx only and Denys any other version
  
  # Required Providers and their Versions
  required_providers {
    # AWS Provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
 
  }
 
}

 
# Providers Configuration Blocks
 provider "aws" {
  region  = "us-east-1"
  profile = "mfadel"
}