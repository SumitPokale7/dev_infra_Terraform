#network
output "vpc_id" {
  value = module.network.vpc_id
}

output "private_subnets" {
  value = module.network.private_subnets
}

output "public_subnets" {
  value = module.network.public_subnets
}

#database

# output "db_secret_arn" {
#   value = module.database.db_secret_arn
# }

output "db_endpoint" {
  value = module.database.db_instance_endpoint
}

#container
output "ecs_cluster_id" {
  value = module.container.cluster_id
}

output "ecs_task_execution_role_arn" {
  value = module.container.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  value = module.container.ecs_task_role_arn
}

output "ecs_sg_id" {
  value = module.container.ecs_sg_id
}

#compute
output "target_group_arns" {
  value = module.compute.target_group_arns
}

output "target_group_attachments" {
  value = module.compute.target_group_attachments
}

output "https_listener_arns" {
  value = module.compute.https_listener_arns
}

output "alb_arn" {
  value = module.compute.alb_arn
}

#elasticache

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}

#bastion public ip

output "instance_ip" {
  value = module.bastion.instance_ip
}

# output "public_ip" {
#   value = module.bastion.public_ip
# }

#s3

# output "lambdas_bucket_arn" {
#   value = module.s3.
# }

# Route 53
# output "zone_id" {
#   value = module.compute.zone_id
# }

# output "domain_record" {
#   value = module.compute.domain_record
# }

# cloudmap
output "cloudmap_namespace_id" {
  value = module.cloudmap.cloudmap_namespace_id
}