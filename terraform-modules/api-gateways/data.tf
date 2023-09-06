data "terraform_remote_state" "lambda_authorizer" {
  backend = "s3"
  config = {
    bucket  = "test-terraform-state-${terraform.workspace}"
    key     = "env://${terraform.workspace}/lambdas/authorizer/terraform-state.tfstate"
    region  = "eu-north-1"
    profile = terraform.workspace
  }
}