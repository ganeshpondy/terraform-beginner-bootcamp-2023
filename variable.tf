# S3 Bucker Variables
# variable "user_uuid" {}

variable "terratowns_endpoint" {
 type = string
}

variable "terratowns_access_token" {
 type = string
}

variable "teacherseat_user_uuid" {
 type = string
}

# variable "bucket_name" {}

# S3 Web-Site Variable
variable "index_html_filepath" {}
variable "error_html_filepath" {}

variable "content_version" {
    type        = number
}

variable "assets_path" {}