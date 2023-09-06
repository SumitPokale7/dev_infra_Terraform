variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "network_mode" {
  type = string
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

variable "vpc_id" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 0
}

variable "launch_type" {
  type    = string
  default = "FARGATE"
}

variable "private_subnets" {
  type = list(any)
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "create_target_group" {
  type    = bool
  default = false
}

variable "create_default_rule" {
  type    = bool
  default = false
}

variable "service_name" {
  type = string
}

variable "domain" {
  type = list(string)
}

variable "additional_domains"{
  type = list(string)
}

variable "create_additional_domains"{
  type = bool
  default = false
}

variable "ecs_cluster_id" {
  type = string
}

variable "ecs_task_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}

variable "ecs_sg_id" {
  type = string
}

variable "container_definitions" {
  type = string
}

variable "application_container_port" {
  type = list(number)
}

variable "nginx_container_port" {
  type    = number
  default = 80
}

variable "https_listener_arns" {
  type = list(string)
}

variable "env" {
  type    = string
  default = "dev"
}

variable "create_service_discovery" {
  type    = bool
  default = false
}