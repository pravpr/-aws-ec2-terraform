
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

#Create a new EC2 launch configuration
resource "aws_instance" "ec2_public" {
  ami                         = data.aws_ami.amzlinux2.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.webserver-security-group.id}"]
  subnet_id                   = aws_subnet.awslab-subnet-public.id
  associate_public_ip_address = true
  tags = {
    "Name" = "EC2-Public"
  }

  # Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ec2-user/${var.key_name}.pem"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
}

#Create a new EC2 launch configuration
resource "aws_instance" "ec2_private" {
  ami                         = data.aws_ami.amzlinux2.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.database-security-group.id}"]
  subnet_id                   = aws_subnet.awslab-subnet-private.id
  associate_public_ip_address = false
  tags = {
    "Name" = "EC2-Private"
  }
}