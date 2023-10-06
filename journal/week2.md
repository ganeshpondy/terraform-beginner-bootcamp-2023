# Terraform Beginner Bootcamp 2023 - Week 2

## TerraTowns Provider Physical Diagram

![TerraTowns_Provider_Physical_Diagram](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/0008aa19-66ce-46bb-b07e-43ae39458cc8)


---

## 2.0.0 Terratowns Mock Server

### Clone the Code from below Repo 
https://github.com/ExamProCo/terratowns_mock_server

- git clone https://github.com/ExamProCo/terratowns_mock_server.git
- cd terratowns_mock_server/
- Delete `.git` file
  `rm -rf .git`

### Update `.gitpod.yml`

```yaml
  - name: sinatra
    before: |
      cd $PROJECT_ROOT
      bundle install
      bundle exec ruby server.rb 
```

### Move the Bin Files

Move the Terratowns Bin Files to bin Directory

---

## 2.0.1 Working with Ruby

### Bundler

Bundler is a package manager for runy.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

---

### Anatomy_of_a_Request

![Anatomy_of_a_Request](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/98a55ec3-ad52-42d4-8d4b-397b75d9d471)


### Check EndPoits (Create, Read, Update, Delete)

Find the Outputs below :

- Create :
  ./bin/terratowns/create
- Read :
  ./bin/terratowns/read <UUID>
- Update :
  ./bin/terratowns/update <UUID>
- Destroy :
  ./bin/terratowns/delete <UUID>

#### Output:

![01_Terratowns_bin_script_03](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/9c57aa8a-7256-4626-9351-78e4cdbf5c36)

#### Ruby Console Output :

![01_Terratowns_02_Console](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/48538fef-955c-48f6-bde6-5fe961bf8545)

---

## 2.1.0 Terraform Provider

### Skeleton Setup 

Create terraform-provider-terratowns Folder and create below Go Fils

1. main.go
2. go.mod
3. go.sum

Create  `terraformrc` file and in bin folder create `build_provider` script

run `go build -o terraform-provider-terratowns_V1.0.0` to Build the Module


---

## 2.2.0 Terratowns Provider Init & Plan 

Update TF_Log variable to get Debug logs for terraform commands. Use below command

```bash
echo $TF_LOG

export TF_LOG=DEBUG
gp env TF_LOG=DEBUG

echo $TF_LOG
DEBUG
```

Update below lines in `.gitpod.yml` file

```yaml
  - name: terraform
    env:
      TF_LOG: DEBUG
```
#### Run Build Provider :

`./bin/build_provider ` to create provider files 

```sh
gitpod /workspace/terraform-beginner-bootcamp-2023/bin (39-terratowns-provider) $ ./build_provider 
gitpod /workspace/terraform-beginner-bootcamp-2023/bin (39-terratowns-provider) $ 

File Created :
gitpod /workspace/terraform-beginner-bootcamp-2023/bin (39-terratowns-provider) $ ls -lrt /home/gitpod/.terraform.d/plugins/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0 

-rwxr-xr-x 1 gitpod gitpod 21051751 Oct  3 01:09 /home/gitpod/.terraform.d/plugins/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0

gitpod /workspace/terraform-beginner-bootcamp-2023/bin (39-terratowns-provider) $ 
```

### run terraform init 

```yaml
gitpod /workspace/terraform-beginner-bootcamp-2023 (39-terratowns-provider) $ terraform init
2023-10-03T01:18:19.051Z [INFO]  Terraform version: 1.5.7
2023-10-03T01:18:19.051Z [DEBUG] using github.com/hashicorp/go-tfe v1.26.0
2023-10-03T01:18:19.051Z [DEBUG] using github.com/hashicorp/hcl/v2 v2.16.2
2023-10-03T01:18:19.051Z [DEBUG] using github.com/hashicorp/terraform-svchost v0.1.0
2023-10-03T01:18:19.051Z [DEBUG] using github.com/zclconf/go-cty v1.12.2
2023-10-03T01:18:19.051Z [INFO]  Go runtime version: go1.20.7
2023-10-03T01:18:19.051Z [INFO]  CLI args: []string{"terraform", "init"}
2023-10-03T01:18:19.051Z [DEBUG] Attempting to open CLI config file: /home/gitpod/.terraformrc
2023-10-03T01:18:19.051Z [INFO]  Loading CLI configuration from /home/gitpod/.terraformrc
2023-10-03T01:18:19.051Z [INFO]  Loading CLI configuration from /home/gitpod/.terraform.d/credentials.tfrc.json
2023-10-03T01:18:19.052Z [DEBUG] checking for credentials in "/home/gitpod/.terraform.d/plugins"
2023-10-03T01:18:19.052Z [DEBUG] Explicit provider installation configuration is set
2023-10-03T01:18:19.052Z [INFO]  CLI command args: []string{"init"}

Initializing the backend...
2023-10-03T01:18:19.054Z [DEBUG] New state was assigned lineage "bc51987b-168e-90e8-40ed-67032bc9f430"
2023-10-03T01:18:19.054Z [DEBUG] checking for provisioner in "."
2023-10-03T01:18:19.060Z [DEBUG] checking for provisioner in "/usr/bin"
2023-10-03T01:18:19.060Z [DEBUG] checking for provisioner in "/home/gitpod/.terraform.d/plugins"

Initializing provider plugins...
- Finding local.providers/local/terratowns versions matching "1.0.0"...
- Installing local.providers/local/terratowns v1.0.0...
- Installed local.providers/local/terratowns v1.0.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

╷
│ Warning: Incomplete lock file information for providers
│ 
│ Due to your customized provider installation methods, Terraform was forced to calculate lock file checksums locally for the
│ following providers:
│   - local.providers/local/terratowns
│ 
│ The current .terraform.lock.hcl file only includes checksums for linux_amd64, so Terraform running on another platform will
│ fail to install these providers.
│ 
│ To calculate additional checksums for another platform, run:
│   terraform providers lock -platform=linux_amd64
│ (where linux_amd64 is the platform to generate)
╵

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
gitpod /workspace/terraform-beginner-bootcamp-2023 (39-terratowns-provider) $ 

```

### run terraform plan

```yaml
gitpod /workspace/terraform-beginner-bootcamp-2023 (39-terratowns-provider) $ terraform plan
2023-10-03T01:19:45.236Z [INFO]  Terraform version: 1.5.7
2023-10-03T01:19:45.236Z [DEBUG] using github.com/hashicorp/go-tfe v1.26.0
2023-10-03T01:19:45.236Z [DEBUG] using github.com/hashicorp/hcl/v2 v2.16.2
2023-10-03T01:19:45.236Z [DEBUG] using github.com/hashicorp/terraform-svchost v0.1.0
2023-10-03T01:19:45.236Z [DEBUG] using github.com/zclconf/go-cty v1.12.2
2023-10-03T01:19:45.236Z [INFO]  Go runtime version: go1.20.7
2023-10-03T01:19:45.236Z [INFO]  CLI args: []string{"terraform", "plan"}
2023-10-03T01:19:45.236Z [DEBUG] Attempting to open CLI config file: /home/gitpod/.terraformrc
2023-10-03T01:19:45.236Z [INFO]  Loading CLI configuration from /home/gitpod/.terraformrc
2023-10-03T01:19:45.236Z [INFO]  Loading CLI configuration from /home/gitpod/.terraform.d/credentials.tfrc.json
2023-10-03T01:19:45.236Z [DEBUG] checking for credentials in "/home/gitpod/.terraform.d/plugins"
2023-10-03T01:19:45.236Z [DEBUG] Explicit provider installation configuration is set
2023-10-03T01:19:45.237Z [INFO]  CLI command args: []string{"plan"}
2023-10-03T01:19:45.238Z [DEBUG] New state was assigned lineage "a05f46e2-a4ef-cde9-5197-8ee782206203"
2023-10-03T01:19:45.290Z [DEBUG] checking for provisioner in "."
2023-10-03T01:19:45.294Z [DEBUG] checking for provisioner in "/usr/bin"
2023-10-03T01:19:45.294Z [DEBUG] checking for provisioner in "/home/gitpod/.terraform.d/plugins"
2023-10-03T01:19:45.294Z [INFO]  backend/local: starting Plan operation
2023-10-03T01:19:45.295Z [DEBUG] created provider logger: level=debug
2023-10-03T01:19:45.295Z [INFO]  provider: configuring client automatic mTLS
2023-10-03T01:19:45.328Z [DEBUG] provider: starting plugin: path=.terraform/providers/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0 args=[.terraform/providers/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0]
2023-10-03T01:19:45.328Z [DEBUG] provider: plugin started: path=.terraform/providers/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0 pid=10354
2023-10-03T01:19:45.328Z [DEBUG] provider: waiting for RPC address: path=.terraform/providers/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0
2023-10-03T01:19:45.334Z [INFO]  provider.terraform-provider-terratowns_v1.0.0: configuring server automatic mTLS: timestamp=2023-10-03T01:19:45.334Z
2023-10-03T01:19:45.346Z [DEBUG] provider: using plugin: version=5
2023-10-03T01:19:45.346Z [DEBUG] provider.terraform-provider-terratowns_v1.0.0: plugin address: network=unix address=/tmp/plugin2606195182 timestamp=2023-10-03T01:19:45.346Z
2023-10-03T01:19:45.364Z [DEBUG] provider.stdio: received EOF, stopping recv loop: err="rpc error: code = Unavailable desc = error reading from server: EOF"
2023-10-03T01:19:45.365Z [DEBUG] provider: plugin process exited: path=.terraform/providers/local.providers/local/terratowns/1.0.0/linux_amd64/terraform-provider-terratowns_v1.0.0 pid=10354
2023-10-03T01:19:45.365Z [DEBUG] provider: plugin exited
2023-10-03T01:19:45.365Z [DEBUG] Building and walking validate graph
2023-10-03T01:19:45.365Z [DEBUG] pruning unused provider["local.providers/local/terratowns"]
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.index_html_filepath" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.error_html_filepath" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.content_version" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.assets_path" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.user_uuid" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.bucket_name" references: []
2023-10-03T01:19:45.366Z [DEBUG] Starting graph walk: walkValidate
2023-10-03T01:19:45.366Z [INFO]  backend/local: plan calling Plan
2023-10-03T01:19:45.366Z [DEBUG] Building and walking plan graph for NormalMode
2023-10-03T01:19:45.366Z [DEBUG] pruning unused provider["local.providers/local/terratowns"]
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.assets_path" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.user_uuid" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.bucket_name" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.index_html_filepath" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.error_html_filepath" references: []
2023-10-03T01:19:45.366Z [DEBUG] ReferenceTransformer: "var.content_version" references: []
2023-10-03T01:19:45.366Z [DEBUG] Starting graph walk: walkPlan
2023-10-03T01:19:45.366Z [DEBUG] no planned changes, skipping apply graph check
2023-10-03T01:19:45.367Z [INFO]  backend/local: plan operation completed

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
gitpod /workspace/terraform-beginner-bootcamp-2023 (39-terratowns-provider) $ 

```
---

## 2.3.0 Update main.go module

All of the code for our server is stored in the `server.rb` file.

---

## 2.4.0 CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

### Custom Terraform Provider

Steps:

./bin/build_provider
terraform init
terraform plan
terraform apply --auto-approve

### Issue : 

```yaml
Error: failed to create home resource, status_code: 401, status: 401 Unauthorized, body map[err:a1003 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid]
│ 
│   with terratowns_home.home,
│   on main.tf line 40, in resource "terratowns_home" "home":
│   40: resource "terratowns_home" "home" {
│ 
```
![2-4-0-tfplan_error](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/4923b81c-f3a9-42d1-95d1-dc0a020b5518)



#### Solution :

in `server.rb` file, modified the UUID value to my UUID value, then `tf apply` worked without issue

```
  def x_user_uuid
    return 'e328f4ab-b99f-421c-84c9-4ccea042c7d1'
  end
```

Then we are able to run `tf apply` without issue and modified changes are updated with issue

![2-4-0-tfapply](https://github.com/ganeshpondy/terraform-beginner-bootcamp-2023/assets/18094905/a973d299-11c5-4bf8-b10a-237bf4600c9d)

---

## 2.5.0 Terratown Connection with Missingo

#### Update UUID & Token as Terraform Env Variable 

```yaml

export TF_VAR_terratowns_access_token="aaaa-1111-2222-2222-bbbb"
gp env TF_VAR_terratowns_access_token="aaaa-1111-2222-2222-bbbb"

teacherseat_user_uuid
export TF_VAR_teacherseat_user_uuid="cccc-1111-2222-2222-dddd"
gp env TF_VAR_teacherseat_user_uuid="cccc-1111-2222-2222-dddd"

gitpod /workspace/terraform-beginner-bootcamp-2023 (41-terratown-test) $ env | grep -i TF_VAR
TF_VAR_teacherseat_user_uuid=aaaa-1111-2222-2222-bbbb
TF_VAR_terratowns_access_token=cccc-1111-2222-2222-dddd

```

### Remove Bucket_name from the Code

We have removed Bucket_name variable from the code, now random name will be generated from the code

### update api url

We have update the API URL from Local to `https://terratowns.cloud/api`

#### terratowns.cloud in Missingo without Backend

#### terratowns.cloud in Missingo with Backend CloudFront






---
