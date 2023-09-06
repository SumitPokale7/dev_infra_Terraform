variable "public_subnets" {}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "vpc_id" {}
variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

variable "https_listener_arns" {
  type = list(string)
}
