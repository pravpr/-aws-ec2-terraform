# aws-ec2-terraform

This repository consists of terraform manifests to create the following resources in AWS

1. One VPC - awslab-vpc
2. One Internet Gateway - internet_gateway
3. One Public Subnet - awslab-subnet-public
4. One Private Subnet - awslab-subnet-private
5. One Route Table - awslab-rt-internet
6. Two Security Groups - Webserver Security Group and Database Server Security Group
7. One Public EC2 instance - EC2-Public
8. One Public EC2 instance - EC2-Private
9. One ssh key named TEST.pem to login into public EC2 instance. From public EC2 instance you can ssh into private EC2 instance.

**Prerequisites to execute the terraform manifests**

1. Download Terraform based on the corresponding Operating System
2. Install Terraform CLI
3. Update provider.tf file using any one of the authentication method mentioned in this link https://registry.terraform.io/providers/hashicorp/aws/latest/docs to authenticate to your AWS account.
4. Execute terraform init, terraform plan, terraform apply commands to create resources in your corresponding AWS account.
