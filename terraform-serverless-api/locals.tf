locals {
  tags = {
    Terraform   = "true"
    Environment = var.api_environment
  }
}