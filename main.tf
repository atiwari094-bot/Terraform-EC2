terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
#Create a Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "my_key"
  public_key = file("terra-ec2-key.pub") # Path to your public key file
}

# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "dev"
    Environment = "dev-vpc" 
  }
}

# Create a Subnet (required for EC2)
resource "aws_subnet" "mysubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "dev-subnet"
    Environment = "dev-subnet" 
  }
}

# Create a Security Group
resource "aws_security_group" "my_sg" {
  name        = "my_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH From anywhere
   }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP From anywhere
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS From anywhere

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"         # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 Instances
resource "aws_instance" "EC2_instance" {
  ami                    = var.ami_id # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type          = var.instance_type
  key_name               = aws_key_pair.my_key.key_name
  count                  = var.instance_count
  subnet_id              = aws_subnet.mysubnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  root_block_device {
    volume_size = var.root_block_device["volume_size"]
    volume_type = var.root_block_device["volume_type"]
    
  }
  tags = {
    Name = "Terraform-EC2"
    Environment = "dev-ec2" 
  }
}
