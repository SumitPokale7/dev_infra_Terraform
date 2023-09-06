module "db" {
  source                              = "terraform-aws-modules/rds/aws"
  version                             = "4.7.0"
  identifier                          = "${var.identifier_name}-${terraform.workspace}"
  vpc_security_group_ids              = [aws_security_group.allow_rds.id]
  auto_minor_version_upgrade          = var.auto_minor_version_upgrade
  max_allocated_storage               = var.max_allocated_storage
  skip_final_snapshot                 = var.skip_final_snapshot
  maintenance_window                  = var.maintenance_window
  allocated_storage                   = var.allocated_storage
  engine_version                      = var.engine_version
  instance_class                      = var.instance_class
  engine                              = var.engine_name
  username                            = var.username
  multi_az                            = var.multi_az
  db_name                             = var.db_name
  tags                                = var.tags
  port                                = "3306"
  iam_database_authentication_enabled = true
  apply_immediately                   = true

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = var.private_subnets

  # DB parameter group
  family = "${var.engine_name}${var.major_engine_version}"

  # DB option group
  major_engine_version = var.major_engine_version

  # Database Deletion Protection
  deletion_protection = var.deletion_protection
}
