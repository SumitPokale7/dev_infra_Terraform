#common
variable "region" {
  type    = string
  default = "eu-north-1"
}

#network
variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(any)
}

variable "public_subnet_cidrs" {
  type = list(any)
}

variable "private_subnets_cidrs" {
  type = list(any)
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

#database
variable "identifier_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "engine_name" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "major_engine_version" {
  type = string
}

variable "family" {
  type = string
}

variable "rotation_days" {
  type    = number
  default = 30
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "max_allocated_storage" {
  type = number
}


variable "allocated_storage" {
  type = number
}

variable "auto_minor_version_upgrade" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}

variable "maintenance_window" {
  type = string
}

variable "db_backup_name" {
  type = string
}

#elasticache
variable "elasticache_parameter_group_name" {
  type        = string
  default     = "default.redis6.x"
  description = "parameter group name for redis"
}

variable "elasticache_engine" {
  type = string
  default = "redis"
}

variable "elasticache_engine_version" {
  type = number
  default = 6.2
}

variable "elasticache_node_type" {
  type = string
  default = "cache.t4g.micro"
}
