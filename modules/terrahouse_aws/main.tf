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

# Create S3 Bucket
resource "aws_s3_bucket" "website_bucket" {
  # Bucket Naming Rules
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
  }
}

# Enable WebSite in the S3 Bucket
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Copy Local Files to S3 Bucket
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath

  etag = filemd5(var.index_html_filepath)   # etag will check the file modified time and copy if the file is modified
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = var.error_html_filepath

  etag = filemd5(var.error_html_filepath)
}