provider "aws" {
  alias  = "alternate_region"
  profile = terraform.workspace
  region = "us-east-1"
}