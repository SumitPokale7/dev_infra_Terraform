variable "api_gateways" {
  type = map(any)
}

variable "api_key_source" {
  type    = string
  default = "HEADER"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}