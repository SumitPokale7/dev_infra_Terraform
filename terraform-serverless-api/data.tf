data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = {
    bucket  = "test-terraform-state-${var.api_environment}"
    key     = "env://${var.api_environment}/infrastructure/terraform-state.tfstate"
    region  = "eu-north-1"
    //profile = terraform.workspace
  }
}
data "archive_file" "bootstrap_lambda" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"

  source {
    content  = "hello"
    filename = "bootstrap.txt"
  }
}