terraform {

  required_providers {
    aws = "4.22.0"
  }

  backend "s3" {
    encrypt = true
    key     = "lambdas/agreement/terraform-state.tfstate"
  }
  required_version = ">= 1.3.0"

}

provider "aws" {
  # profile = terraform.workspace
  region = var.region
}

