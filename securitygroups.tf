

# Create Security Group for the Web Server

resource "aws_security_group" "webserver-security-group" {
  depends_on = [
    aws_vpc.awslab-vpc,
    aws_subnet.awslab-subnet-public,
    aws_subnet.awslab-subnet-private
  ]
  name        = "Webserver Security Group"
  description = "Enable SSH access on Port 22"
  vpc_id      = aws_vpc.awslab-vpc.id
  # allow ingress port 22
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  # allow ingress port 80 
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
  }

  # allow ingress port 443 
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  # allow ingress ephemeral ports 
  ingress {
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = -1
    to_port     = -1
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Webserver Security Group"
  }
}


# Create Security Group for the database Server

resource "aws_security_group" "database-security-group" {
  name   = "Database server Security Group"
  vpc_id = aws_vpc.awslab-vpc.id

  # allow ingress ephemeral 22 port 
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["172.16.1.0/24"]
    from_port   = 22
    to_port     = 22
  }

  # allow ingress port 3110 
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["172.16.1.0/24"]
    from_port   = 3110
    to_port     = 3110
  }

  # allow ingress ephemeral ports 
  ingress {
    protocol    = "icmp"
    cidr_blocks = ["172.16.1.0/24"]
    from_port   = -1
    to_port     = -1
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Database Server Security Group"
  }
}