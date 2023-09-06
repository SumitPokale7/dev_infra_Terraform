
resource "aws_eip" "bastion_eip" {
  instance = module.ec2_instance.id
  vpc      = true
  tags = merge(
    {
      Name = "bastion-eip-${terraform.workspace}"
    },
    var.tags
  )
}


resource "aws_eip_association" "bastion_eip_assoc" {
  instance_id   = module.ec2_instance.id
  allocation_id = aws_eip.bastion_eip.id
}