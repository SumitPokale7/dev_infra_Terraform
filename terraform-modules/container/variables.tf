variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "cloudwatch_group" {
  type    = string
  default = "ecs"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

variable "vpc_id" {
  type = string
}

variable "test_ecr_repos" {
  type = map(any)
}

variable "aws_iam_policy_settings" {
  description = "AWS IAM policy settings"
  default = {}
  type = map(object({
    actions = list(string)
    resources = list(string)
  }))
}