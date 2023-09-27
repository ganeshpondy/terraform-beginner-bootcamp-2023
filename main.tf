
resource "aws_s3_bucket" "website_bucket" {
  # Bucket Naming Rules
  bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
  }
}

