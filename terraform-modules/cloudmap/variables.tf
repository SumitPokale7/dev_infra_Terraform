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