module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "bastion-host-${terraform.workspace}"
  vpc_security_group_ids = [aws_security_group.allow_ssh_traffic.id]
  key_name               = aws_key_pair.bastion-key.id
  ami                    = "ami-05c42683296709b61"
  subnet_id              = var.public_subnets
  instance_type          = var.instance_type
  monitoring             = true
  tags = merge(
    {
      Name = "bastion-host-${terraform.workspace}"
    },
    var.tags
  )
}
