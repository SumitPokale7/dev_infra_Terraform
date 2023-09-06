#common
variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}
variable "network_mode" {
  type    = string
  default = "awsvpc"
}

variable "cloudwatch_group" {
  type    = string
  default = "ecs"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "stage"
    Terraform   = true
  }
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "launch_type" {
  type    = string
  default = "FARGATE"
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "service_name" {
  type = string
}

variable "application_container_port" {
  type = list(number)
}

variable "domain" {
  type    = list(string)
}

variable "app_version" {
  type    = string
  default = "latest"
}

variable "additional_domains" {
  type = list(string)
  default = ["default"]
}