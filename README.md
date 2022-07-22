# aws-ec2-terraform

This repository consists of terraform manifests to create the following resources in AWS

1. One VPC - awslab-vpc
2. One Internet Gateway - internet_gateway
3. One Public Subnet - awslab-subnet-public
4. One Private Subnet - awslab-subnet-private
5. One Route Table for internet gateway- awslab-rt-internet
6. One Elastic IP for NAT gateway
7. One NAT gateway
8. One Route table for NAT gateway
9. Two Security Groups - Webserver Security Group and Database Server Security Group
10. One Public EC2 instance with apache httpd installed- EC2-Webserver
11. One Private EC2 instance with mariadb installed- EC2-Databaseserver
12. One ssh key named prpr-key.pem to login into public EC2 instance. From public EC2 instance you can ssh into private EC2 instance using prpr-key.pem.
13. One S3 bucket - prpr-terraform-state-backend
14. One Dynamodb table - terraform_state

**Prerequisites to execute the terraform manifests**
1. Download Terraform based on the corresponding Operating System
2. Install Terraform CLI

**Steps to provision resources in AWS using terraform**
1. Clone this repository and get inside root directory
2. For the very first time, comment all the lines in backend.tf file and execute terraform init for initialization. Otherwise it will fail as S3 bucket is not yet created.
2. Execute terraform init, terraform plan, terraform apply commands to create resources in your corresponding AWS account.
3. After execcuting terraform apply command, you will get Public EC2 instance public IP and Private EC2 instance private IP and also prpr-key.pem ssh key will be created in your root directory.
4. Using the below command you can login into Public EC2 instance
   **Command:** ssh -i prpr-key.pem ec2-user@public-EC2-instance-public-ip
5. From public EC2 instance, you can login into Private EC2 instance using the below command
   **Command:** ssh -i prpr-key.pem ec2-user@private-EC2-instance-private-ip
6. Uncomment all the lines in backend.tf and execute terraform init command. This will ask to migrate terraform.tfstate file from local to S3 bucket which we created. Provide yes and press enter. This will migrate the terraform.tfstate from local to S3 bucket.
