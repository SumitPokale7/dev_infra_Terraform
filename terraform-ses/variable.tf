variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

# variable "email_identity" {
#   type = string
# }

variable "domain_identity" {
  type = string
}
