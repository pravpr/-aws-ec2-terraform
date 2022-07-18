# aws-ec2-terraform

This repository consists of terraform manifests to create 1 VPC, 1 Internet Gateway, 1 Public Subnet, 1 Private Subnet, 1 Route Table, 2 Security Groups and 2 EC2 instance(Webserver) with Public subnet and another instance(Database) with Private subnet. 

**Prerequisites to execute the terraform manifests**

1. Download Terraform based on the corresponding Operating System
2. Install Terraform CLI
3. Update provider.tf file using any one of the authentication method mentioned in this link https://registry.terraform.io/providers/hashicorp/aws/latest/docs to authenticate to your AWS account.
4. Execute terraform init, terraform plan, terraform apply commands to create resources in your corresponding AWS account.
