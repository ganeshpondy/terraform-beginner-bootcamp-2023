terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "website_bucket" {
  # Bucket Naming Rules
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
  }
}

