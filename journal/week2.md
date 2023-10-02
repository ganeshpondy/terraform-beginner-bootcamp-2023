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
