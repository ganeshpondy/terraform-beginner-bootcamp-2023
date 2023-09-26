output "random_bucket_name" {
  value = random_string.bucket_name.result
}

output "S3_bucket_name" {
  value = aws_s3_bucket.s3-bucket.id
}

