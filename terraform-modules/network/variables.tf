variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "vpc_name" {
  type    = string
  default = "test"
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnets_cidrs" {
  type = list(string)
}

variable "enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "enable_dns_support" {
  type    = bool
  default = false
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "single_nat_gateway" {
  type    = bool
  default = false
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}