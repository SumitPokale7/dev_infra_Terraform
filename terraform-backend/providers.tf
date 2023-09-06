terraform {
  required_providers {
    aws = "4.22.0"
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region  = var.region
  profile = "dev"
}
