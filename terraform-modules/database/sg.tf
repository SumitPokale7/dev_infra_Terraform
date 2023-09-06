
resource "aws_security_group" "allow_rds" {
  name        = "allow-rds-${terraform.workspace}"
  description = "Allow DB inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "DB traffic from VPC"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
    Name = "allow-db-inbound-traffic-${terraform.workspace}"
    },
    var.tags
  )
}
