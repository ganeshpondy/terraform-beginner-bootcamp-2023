# Terraform Beginner Bootcamp 2023 - Week 1

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
