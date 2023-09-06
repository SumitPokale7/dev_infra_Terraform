locals {
  tags = {
    Terraform   = "true"
    Environment = "${var.api_base_name}-${var.api_environment}"
    Serverless  = "true"
  }
}