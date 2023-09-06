data "terraform_remote_state" "apigateway" {
  backend = "s3"
  config = {
    bucket  = "test-terraform-state-${terraform.workspace}"
    key     = "env://${terraform.workspace}/api-gateway/terraform-state.tfstate"
    region  = "eu-north-1"
    profile = terraform.workspace
  }
}