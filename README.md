# aws-ec2-terraform

This repository consists of terraform manifests to create the following resources in AWS

1. One VPC - awslab-vpc
2. One Internet Gateway - internet_gateway
3. One Public Subnet - awslab-subnet-public
4. One Private Subnet - awslab-subnet-private
5. One Route Table - awslab-rt-internet
6. Two Security Groups - Webserver Security Group and Database Server Security Group
7. One Public EC2 instance - EC2-Public
8. One Private EC2 instance - EC2-Private
9. One ssh key named TEST.pem to login into public EC2 instance. From public EC2 instance you can ssh into private EC2 instance.

**Prerequisites to execute the terraform manifests**
1. Download Terraform based on the corresponding Operating System
2. Install Terraform CLI

**Steps to provision resources in AWS using terraform**
1. Clone this repository and get inside root directory
2. Update provider.tf file to authenticate your AWS account by following any one of the authentication method mentioned in this link https://registry.terraform.io/providers/hashicorp/aws/latest/docs.
3. Execute terraform init, terraform plan, terraform apply commands to create resources in your corresponding AWS account.
4. You will get public EC2 instance public IP and Private EC2 instance private IP and also TEST.pem ssh key will be created in your root directory.
5. Using the below command you can login into Public EC2 instance
   **Command:** ssh -i TEST.pem ec2-user@public-EC2-instance-public-ip
