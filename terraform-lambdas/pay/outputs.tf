output "authorizer_arn" {
  value = module.lambda_function_existing_package_s3.lambda_function_invoke_arn
}