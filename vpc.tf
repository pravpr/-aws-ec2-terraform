# Create VPC
# terraform aws create vpc
resource "aws_vpc" "awslab-vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "awslab-vpc"
  }
}


# Create Internet Gateway and Attach it to VPC
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.awslab-vpc.id
  tags = {
    Name = "internet_gateway"
  }
}


# Create Public Subnet
resource "aws_subnet" "awslab-subnet-public" {
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = var.Public_Subnet_1
  availability_zone       = var.region
  map_public_ip_on_launch = true
  tags = {
    Name = "awslab-subnet-public"
  }
}


# Create Route Table and Add Public Route
resource "aws_route_table" "awslab-rt-internet" {
  vpc_id = aws_vpc.awslab-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = {
    Name = "awslab-rt-internet"
  }
}

# Associate Public Subnet to "Public Route Table"
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.awslab-subnet-public.id
  route_table_id = aws_route_table.awslab-rt-internet.id
}


# Create Private Subnet
resource "aws_subnet" "awslab-subnet-private" {
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = var.Private_Subnet_1
  availability_zone       = var.region
  map_public_ip_on_launch = false
  tags = {
    Name = "awslab-subnet-private"
  }
}
