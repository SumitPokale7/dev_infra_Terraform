module "secret-manager-with-rotation" {
  source                     = "../secret-manager-with-rotation"
  mysql_dbInstanceIdentifier = "${var.identifier_name}-${terraform.workspace}"
  mysql_host                 = split(":", module.db.db_instance_endpoint)[0]
  name                       = "rds-credentials-${terraform.workspace}"
  mysql_password             = module.db.db_instance_password
  subnets_lambda             = var.private_subnets
  rotation_days              = var.rotation_days
  mysql_username             = var.username
  mysql_dbname               = var.db_name
  tags                       = var.tags
  db_users                   = local.db_users
  # depends_on = [
  #   module.db
  # ]
}
