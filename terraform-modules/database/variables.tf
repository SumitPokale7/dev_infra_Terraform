variable "region" {
  type    = string
  default = "eu-north-1"
}

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

variable "port" {
  type    = number
  default = 3306
}

variable "rotation_days" {
  type    = number
  default = 30
}

variable "multi_az" {
  type = bool
  default = true
}

variable "deletion_protection" {
  type = bool
  default = true
}

variable "skip_final_snapshot" {
  type = bool
  default = false
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

variable "public_subnets" {
  type = list
}

variable "private_subnets" {
  type = list
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "auto_minor_version_upgrade" {
  type = bool
  default = false
}

variable "maintenance_window" {
  type = string
}

variable "db_backup_name" {
  type = string 
}