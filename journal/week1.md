# Terraform Beginner Bootcamp 2023 - Week 1

## 1.0.0 Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

---

## 1.1.0 Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

![Variables_Flow](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/3dcdfa00-6d2e-4b9c-be70-8a743b75429c)


---

## 1.2.0 Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

``` TF
Import :

terraform import aws_s3_bucket.s3-bucket <bucketname>

terraform Import random_string.bucket_name <bucketname>

```

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift



### S3 Bucket Name Varaiable with Condition and Error Message 

``` JSON
variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = (
      length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket_name))
    )
    error_message = "The bucket name must be between 3 and 63 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  }
}
```

---

## 1.3.0 Create module as 'terrahouse_aws'

update the output.tf in base 

```json
output "bucket_name" {
  value = module.terrahousr_aws.bucket_name
}
```
---

## 1.4.0 - S3 Static Website Hosting

Enable WebSite in the S3 Bucket

``` tf
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

```

Copy `index.html` and `error.html` file to S3 Bucket

`etag` will check the file modified time and copy if the file is modified

``` tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath

  etag = filemd5(var.index_html_filepath)   
}

resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = var.error_html_filepath

  etag = filemd5(var.error_html_filepath)
}
```

---

## 1.4.0 - CloudFront and S3 Bucket IAM Policy

Create CloudFront and Orgin Access Policy

Create IAM Policy for the S3 Bucket 

``` tf
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action" = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
      "Condition" = {
      "StringEquals" = {
          "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
        }
      }
    }
  })
}

```

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## 1.5.0 Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec

#### Error Page

![04_Error](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/4494e3cd-74c5-4474-a034-54afd9ef658b)

#### Index Page

![05_index_01](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/bc91b795-ec25-41dd-8e54-aba6d833992f)

---

## 1.6.0 content version

#### lifecycle will copy only `content_version` value chaged, it will not copy if only etag changed

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  content_type = "text/html"

  etag = filemd5(var.index_html_filepath)   # etag will check the file modified time and copy if the file is modified
  # lifecycle will copy only `content_version` value chaged, it will not copy if only etag changed
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}
```

### Load the content_version from main variable
```tf
resource "terraform_data" "content_version" {
  input = var.content_version
}

```
content_version = 2

![05_index_contevt_version_02](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/f5bab798-43c9-40ec-9add-b4461f77698e)


content_version = 4

![05_index_contevt_version_03](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/fcca582a-9e4d-415e-a082-cdddc9c0a3d8)

![05_index_contevt_version_04](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/7fbce5f1-4fca-4641-829a-6a0ad1df0702)

---

## 1.7.0 Load Images

#### Upload Impages in webPage

```tf
resource "aws_s3_object" "upload_assets" {
  for_each = fileset(var.assets_path,"*.{jpg,png,gif,JPG}")
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "assets/${each.key}"
  source = "${var.assets_path}/${each.key}"
  etag = filemd5("${var.assets_path}/${each.key}")
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
}
```

![06_index](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/a9499276-1134-4091-8354-1630c46b274d)


---
## 1.8.0 Enable VSC Extenstion

add below lines in `.gitpod.yaml` 
```
vscode:
  extensions:
    - amazonwebservices.aws-toolkit-vscode
    - hashicorp.terraform
    - mhutchie.git-graph
    - phil294.git-log--graph
```
