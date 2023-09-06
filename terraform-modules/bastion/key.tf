resource "aws_key_pair" "bastion-key" {
  key_name   = "bastion-key-${terraform.workspace}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQDOgyyUkXJXre/zhM6UJzuxG48YgpjFQA7qkYuhWCwAw+AE9kAOv3jaIu1n+x6ARS8oW82n4quIrNJNqVuEdaY6P5yexfSyksMi9OuVOZWr5yNSAGF4k1qTE+AKV0+xNPaz9dgj/UXXV6vnX8d3yARlMed/yUmjzwycLA16XTIk/w== noname"
}