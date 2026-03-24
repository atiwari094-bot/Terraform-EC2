#output for EC2 instance public IP, public DNS, and private IP
output "instance_public_ip" {
  value = aws_instance.EC2_instance[*].public_ip
}

output "instance_public_dns" {
  value = aws_instance.EC2_instance[*].public_dns
}

output "instance_private_ip" {
  value = aws_instance.EC2_instance[*].private_ip
}
output "instance_state"{
    value = aws_instance.EC2_instance[*].instance_state

    
}