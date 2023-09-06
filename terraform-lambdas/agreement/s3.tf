resource "aws_s3_object" "lambda_paths" {
  key        = "/agreement/releases/"
  bucket     = "test-lambdas-${terraform.workspace}"
}