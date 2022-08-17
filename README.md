# Mywebapp infra automation.

# This repo contains IAC codes for infrastructure for a static website hosted in AWS S3 and served using AWS Cloudfront CDN.

# Terraform states are stored in S3 bucket and mention the correct bucket name in the main.tf

# Parameters related to this project is stored in the file "mywebapp-env-var.tfvars". Review and modify the parameters.

### To initialize the project,

terraform init

### To plan the infra changes,

terraform plan -var-file=mywebapp-env-var.tfvars

### To apply the infra changes,

terraform apply -var-file=mywebapp-env-var.tfvars

### Terraform output will display the CDN domain name. Now point the domain to this CDN from the DNS.

