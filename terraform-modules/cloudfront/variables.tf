variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

variable "cloudfront_aliases" {
  type = list(string)
}

variable "bucket_name" {
  type = string
}

variable "name" {
  type = string
}

variable "oac_name" {
  type = string
}

variable "cache_behavior" {
  type = map(any)
}