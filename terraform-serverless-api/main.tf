module "test-sls-api" {
  source                         = "../terraform-modules/serverless-api"
  region                         = var.region
  function_package               = data.archive_file.bootstrap_lambda.output_path
  lambda_src_path                = var.lambda_src_path
  api_base_name                  = var.api_base_name
  api_environment                = var.api_environment
  rds_vpc_subnet_ids             = data.terraform_remote_state.infrastructure.outputs.private_subnets
  rds_vpc_security_group_ids     = var.rds_vpc_security_group_ids
  lambda_rds_connect_secret_name = var.lambda_rds_connect_secret_name
  lambda_timeout                 = var.lambda_timeout
}

