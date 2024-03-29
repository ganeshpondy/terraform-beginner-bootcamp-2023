terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

# provider "aws" {
#   # Configuration options
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
# To get command `aws sts get-caller-identity` details
data "aws_caller_identity" "current" {}