# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distribution

This project is built against Ubunutu.
Please consider checking your Linux Distrubtion and change accordingly to distrubtion needs. 

[How To Check OS Version in Linux](
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ uname -srm
Linux 6.1.44-060144-generic x86_64

$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install Terraform CLI.

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod 744 ./bin/install_terraform_cli
```

### ENV Variable

Create `.env.example` file

```
cat .env.example 
PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'
```


``` BASH
$ export PROJECT_ROOT='/workspace/terraform-beginner-boo
tcamp-2023'
$ gp env PROJECT_ROOT='/workspace/terraform-beginner-boo
tcamp-2023'
PROJECT_ROOT=/workspace/terraform-beginner-bootcamp-2023
$ echo $PROJECT_ROOT
/workspace/terraform-beginner-bootcamp-2023
$ 
```

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

- Create ./bin/install_aws_cli.sh
- Create IAM User in AWS Console with Admin Privileges
- Export the Crediantial into Env Variables

```bash
#!/usr/bin/env bash

cd /workspace

rm -f '/workspace/awscliv2.zip'
rm -rf '/workspace/aws'

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

aws sts get-caller-identity

cd $PROJECT_ROOT
```

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

```bash
> aws sts get-caller-identity

Unable to locate credentials. You can configure credentials by running "aws configure".
```

#### Export the Crediantial into Env Variables

export AWS_ACCESS_KEY_ID="USERID"
export AWS_SECRET_ACCESS_KEY="Password+Uo64vZNyt"
export AWS_DEFAULT_REGION="ap-south-1"

gp env AWS_ACCESS_KEY_ID="USERID"
gp env AWS_SECRET_ACCESS_KEY="Password+Uo64vZNyt"
gp env AWS_DEFAULT_REGION="ap-south-1"

env | grep -i aws_

```JSON
gitpod /workspace/terraform-beginner-bootcamp-2023 (main) $ aws sts get-caller-ident
> aws sts get-caller-identity
{
    "UserId": "USERID",
    "Account": "Account-Number",
    "Arn": "arn:aws:iam::Account-Number:user/IAM-Username"
}
gitpod /workspace/terraform-beginner-bootcamp-2023 (main) $
```


---

## 0.5.0 Terraform Randam ID for S3 Bucket

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

#### Randon Number main.tf code 

```JSON
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  
}

resource "random_string" "bucket_name" {
  length = 16
  special = false
}

output "random_bucket_name" {
    value = random_string.bucket_name.result
}

```

---

## 0.6.0 Create S3 Bucket with Random Value

Added AWS Provider in the Code and added S3 Bucket Creation Steps. S3 Bucket Name will the taken form the Random Value Output.

``` JSON
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}

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
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

output "S3_bucket_name" {
  value = aws_s3_bucket.s3-bucket.id
}
```

Outputs :

```YAML
S3_bucket_name     = "orjschtzeb8oiumf2ljfis22xmghu8mf"
random_bucket_name = "orjschtzeb8oiumf2ljfis22xmghu8mf"
```
---

## 0.7.0 Terraform Cloud

1. Create organization and workspaces and add below line in main.tf to update Teraform backend in Terraform CLoud

``` JSON
terraform {
  cloud {
    organization = "Terraform_Beginner_Bootcamp_Ganeshpondy"
    workspaces {
      name = "terra-house-1"
    }
  }
}
```

2. Add AWS Crediantials as Variables in Terraform Cloud to run terraform commands sucessfully.

