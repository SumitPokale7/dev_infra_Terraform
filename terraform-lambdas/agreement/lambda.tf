module "lambda_function_existing_package_s3" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "Api${var.lambda_name}"
  handler       = "lambda_handler"
  runtime       = "nodejs16.x"
  allowed_triggers = {
    APIGatewaytest = {
      service    = "apigateway"
      source_arn = data.terraform_remote_state.apigateway.outputs.api_gateway_arn.test-api
    }
  }
  create_current_version_allowed_triggers = false
  create_package                          = false
  s3_existing_package = {
    bucket = "test-lambdas-${terraform.workspace}"
    key    = "${var.lambda_name}/releases/${var.lambda_version}/${var.lambda_name}.zip"
  }
  # /${var.version}
  tags = merge(
    {
      Name = "lambda-${var.lambda_name}-${terraform.workspace}"
    },
    var.tags
  )
}
