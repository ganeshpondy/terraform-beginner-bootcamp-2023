<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

- [Terraform Beginner Bootcamp 2023](#terraform-beginner-bootcamp-2023)
   * [Semantic Versioning :mage:](#semantic-versioning-mage)
   * [Install the Terraform CLI](#install-the-terraform-cli)
      + [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
      + [Considerations for Linux Distribution](#considerations-for-linux-distribution)
      + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
         - [Execution Considerations](#execution-considerations)
         - [Linux Permissions Considerations](#linux-permissions-considerations)
      + [ENV Variable](#env-variable)
      + [AWS CLI Installation](#aws-cli-installation)
         - [Export the Crediantial into Env Variables](#export-the-crediantial-into-env-variables)
   * [0.5.0 Terraform Randam ID for S3 Bucket](#050-terraform-randam-id-for-s3-bucket)
      + [Terraform Lock Files](#terraform-lock-files)
         - [Randon Number main.tf code ](#randon-number-maintf-code)
   * [0.6.0 Create S3 Bucket with Random Value](#060-create-s3-bucket-with-random-value)
   * [0.7.0 Terraform Cloud](#070-terraform-cloud)
   * [0.8.0 generate_tfrc_credentials automated](#080-generate_tfrc_credentials-automated)
   * [0.9.0 TF Aliase](#090-tf-aliase)

<!-- TOC end -->

<!-- TOC --><a name="terraform-beginner-bootcamp-2023"></a>
# Terraform Beginner Bootcamp 2023

<!-- TOC --><a name="semantic-versioning-mage"></a>
## Semantic Versioning :mage:

This project is going utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

<!-- TOC --><a name="install-the-terraform-cli"></a>
## Install the Terraform CLI

<!-- TOC --><a name="considerations-with-the-terraform-cli-changes"></a>
### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


<!-- TOC --><a name="considerations-for-linux-distribution"></a>
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

<!-- TOC --><a name="refactoring-into-bash-scripts"></a>
### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install Terraform CLI.

<!-- TOC --><a name="execution-considerations"></a>
#### Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform_cli`

<!-- TOC --><a name="linux-permissions-considerations"></a>
#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod 744 ./bin/install_terraform_cli
```

<!-- TOC --><a name="env-variable"></a>
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

<!-- TOC --><a name="aws-cli-installation"></a>
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

<!-- TOC --><a name="export-the-crediantial-into-env-variables"></a>
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

<!-- TOC --><a name="050-terraform-randam-id-for-s3-bucket"></a>
## 0.5.0 Terraform Randam ID for S3 Bucket

<!-- TOC --><a name="terraform-lock-files"></a>
### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

<!-- TOC --><a name="randon-number-maintf-code"></a>
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

<!-- TOC --><a name="060-create-s3-bucket-with-random-value"></a>
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

<!-- TOC --><a name="070-terraform-cloud"></a>
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
and S3 Bucket is created sucessfully.

![02_S3_Bucket_Name](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/c794e1ac-7eca-45e2-812b-0fe7030382f4)




Issue : After adding Terraform Cloud Backend, Terrafprm Plan is getting below error 

```
Error: No valid credential sources found
with provider["registry.terraform.io/hashicorp/aws"]
on main.tf line 20, in provider "aws":
provider "aws" {
Please see https://registry.terraform.io/providers/hashicorp/aws
for more information about providing credentials.

Error: failed to refresh cached credentials, no EC2 IMDS role found, operation error ec2imds: GetMetadata, request canceled, context deadline exceeded
```

Solution:
Issue is Resolved by adding AWS Crediantial as Variable in Terraform CLoud. 
Please refer below screenshots for the details steps


![01_Terraform_Variables](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/14f728db-b690-40c2-ae7f-1fc15462dd3f)

---

<!-- TOC --><a name="080-generate_tfrc_credentials-automated"></a>
## 0.8.0 generate_tfrc_credentials automated

We have automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

---

<!-- TOC --><a name="090-tf-aliase"></a>
## 0.9.0 TF Aliase

Create new file `./bin/set_tf_alias` and add the file in `.gitpod.yml`

```sh
#!/usr/bin/env bash

# Check if the alias already exists in the .bash_profile
grep -q 'alias tf="terraform"' ~/.bash_profile

# $? is a special variable in bash that holds the exit status of the last command executed
if [ $? -ne 0 ]; then
    # If the alias does not exist, append it
    echo 'alias tf="terraform"' >> ~/.bash_profile
    echo "Alias added successfully."
else
    # Inform the user if the alias already exists
    echo "Alias already exists in .bash_profile."
fi

# Optional: source the .bash_profile to make the alias available immediately
source ~/.bash_profile

```

```sh
  - name: terraform
    before: |
      source ./bin/set_tf_alias
      ...
      ...
  - name: aws-cli
    env:
      AWS_CLI_AUTO_PROMPT: on-partial
    before: |
      source ./bin/set_tf_alias
```

---
