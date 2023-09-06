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

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(any)
}

variable "lb_type" {
  type    = string
  default = "application"
}
