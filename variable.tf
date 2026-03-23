# Define a variable for the vpc CIDR block
variable "vpc_cidr_block" { 
  default = "10.0.0.0/16"
  type    = string  
}
#Define a variable for the subnet CIDR block
variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
  type    = string
}
# Define a variable for the availability zone
variable "availability_zone" {
  default = "us-east-1a"
  type    = string
}   
# Define a variable for the region
variable "region" {
  default = "us-east-1"
  type    = string  
}
#define Variable for Ec2 instnce count
variable "instance_count" {
  default = 1
  type    = number  
}
# Define a variable for the instance type
variable "instance_type" {
  default = "t2.micro"
  type    = string  
}
# Define a variable for the AMI ID
variable "ami_id" {
    default = "ami-02dfbd4ff395f2a1b" # Amazon Linux 2 AMI (HVM), SSD Volume Type
    type    = string  
    } 
#Define a variable for tags
variable "tags" {
  default = {
    Name = "dev"
    Environment = "dev-vpc" 
  }
  type = map(string)
}
#define variable for root block device
variable "root_block_device" {
  default = {
    volume_size = 10
    volume_type = "gp3"
  }
  type = map(any)
}