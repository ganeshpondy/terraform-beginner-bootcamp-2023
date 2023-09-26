
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length   = 32
  special  = false
}

resource "aws_s3_bucket" "s3-bucket" {
  # Bucket Naming Rules
  bucket = random_string.bucket_name.result
  tags = {
    UserUuid = var.user_uuid
  }
}

