variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "cloudfront_aliases" {
  type = list(string)
}

variable "cloudfront_aliases_bot" {
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}
