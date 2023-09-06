output "db_instance_id" {
  value = module.db.db_instance_id
}

output "db_instance_endpoint" {
  value = module.db.db_instance_endpoint
}

output "db_username" {
  value = var.username
}

output "db_name" {
  value = var.db_name
}

output "secret_arns" {
  value = module.secret-manager-with-rotation.secret_arns
}