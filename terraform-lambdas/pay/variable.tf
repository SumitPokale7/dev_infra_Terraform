variable "region" {
  type = string
}

variable "lambda_version" {
  type = string
  # default = "latest"
}

variable "lambda_name" {
  type    = string
  default = "pay"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}