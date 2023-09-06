variable "region" {
  type    = string
  default = "eu-north-1"
}
variable "rds_vpc_subnet_ids" {
  type    = list(string)
  default = []
}
variable "rds_vpc_security_group_ids" {
  type    = list(string)
  default = []
}
variable "lambda_rds_connect_secret_name" {
  type    = string
  default = ""
}
variable "api_base_name" {
  type    = string
}
variable "api_environment" {
  type    = string
}
variable "lambda_src_path" {
  type    = string
}
variable "function_package" {
  type    = string
}
variable "lambda_timeout" {
  type    = number
  default = 30
}
