
resource "aws_security_group" "allow_traffic" {
  name        = "allow-internet-traffic-${terraform.workspace}"
  description = "allow internet traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = merge(
    {
      Name = "allow-internet-traffic-${terraform.workspace}"
    },
    var.tags
  )
}
