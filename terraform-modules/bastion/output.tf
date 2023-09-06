output "instance_ip" {
  description = "The public ip for ssh access"
  value       = module.ec2_instance.public_ip
}

# output "public_ip" {
#   value = aws_eip.bastion_eip.public_ip
# }