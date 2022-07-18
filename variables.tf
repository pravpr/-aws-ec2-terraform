variable "vpc-cidr" {
  default     = "172.16.0.0/16"
  description = "VPC CIDR BLOCK"
  type        = string
}

variable "Public_Subnet_1" {
  default     = "172.16.1.0/24"
  description = "Public_Subnet_1"
  type        = string
}

variable "Private_Subnet_1" {
  default     = "172.16.2.0/24"
  description = "Private_Subnet_1"
  type        = string
}


variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "region" {
  type    = string
  default = "us-east-2a"
}

variable "key_name" {
  default = "TEST"
  type    = string
}