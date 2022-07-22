# S3 backend to store terraform state file
terraform {
  backend "s3" {
    bucket         = "prpr-terraform-state-backend"
    key            = "terraform-ec2/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform_state"
  }
}
