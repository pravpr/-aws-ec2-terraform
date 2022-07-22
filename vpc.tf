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


# Create Public Subnet
resource "aws_subnet" "awslab-subnet-public" {
  depends_on = [
    aws_vpc.awslab-vpc
  ]
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = var.Public_Subnet_1
  availability_zone       = var.region
  map_public_ip_on_launch = true
  tags = {
    Name = "awslab-subnet-public"
  }
}

# Create Private Subnet
resource "aws_subnet" "awslab-subnet-private" {
  depends_on = [
    aws_vpc.awslab-vpc,
    aws_subnet.awslab-subnet-public
  ]
  vpc_id                  = aws_vpc.awslab-vpc.id
  cidr_block              = var.Private_Subnet_1
  availability_zone       = var.region
  map_public_ip_on_launch = false
  tags = {
    Name = "awslab-subnet-private"
  }
}


# Create Internet Gateway and Attach it to VPC
resource "aws_internet_gateway" "internet-gateway" {
  depends_on = [
    aws_vpc.awslab-vpc,
    aws_subnet.awslab-subnet-public,
    aws_subnet.awslab-subnet-private
  ]
  vpc_id = aws_vpc.awslab-vpc.id
  tags = {
    Name = "internet_gateway"
  }
}


# Create Route Table and Add Public Route
resource "aws_route_table" "awslab-rt-internet" {
  depends_on = [
    aws_vpc.awslab-vpc,
    aws_internet_gateway.internet-gateway
  ]
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
  depends_on = [
    aws_vpc.awslab-vpc,
    aws_subnet.awslab-subnet-public,
    aws_subnet.awslab-subnet-private,
    aws_route_table.awslab-rt-internet
  ]
  subnet_id      = aws_subnet.awslab-subnet-public.id
  route_table_id = aws_route_table.awslab-rt-internet.id
}


# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.public-subnet-1-route-table-association
  ]
  vpc = true
}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id

  # Associating it in the Public Subnet!
  subnet_id = aws_subnet.awslab-subnet-public.id
  tags = {
    Name = "Nat-Gateway_Project"
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.awslab-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}

# Creating an Route Table Association of the NAT Gateway route table with the Private Subnet!
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

  #  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id = aws_subnet.awslab-subnet-private.id

  # Route Table ID
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}