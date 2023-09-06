resource "aws_s3_object" "lambda_paths" {
  key        = "/pay/releases/"
  bucket     = "test-lambdas-${terraform.workspace}"
}