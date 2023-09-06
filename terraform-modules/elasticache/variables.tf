variable "private_subnets" {
  type = list
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "port" {
  type    = number
  default = 6379
}

variable "parameter_group_name" {
    type        = string
    default     = "default.redis6.x"
    description = "parameter group name for redis"
}

variable "engine" {
  type = string
  default = "redis"
}

variable "engine_version" {
  type = number
  default = 6.2
}

variable "node_type" {
  type = string
  default = "cache.t4g.micro"
}