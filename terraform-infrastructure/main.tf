module "network" {
  source                = "../terraform-modules/network"
  vpc_cidr              = var.vpc_cidr
  azs                   = var.azs
  private_subnets_cidrs = var.private_subnets_cidrs
  public_subnet_cidrs   = var.public_subnet_cidrs
  enable_dns_hostnames  = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support
  enable_nat_gateway    = var.enable_nat_gateway
  single_nat_gateway    = var.single_nat_gateway
  tags                  = local.tags
}

module "database" {
  source                = "../terraform-modules/database"
  private_subnets       = module.network.private_subnets
  public_subnets        = module.network.public_subnets
  max_allocated_storage = var.max_allocated_storage
  major_engine_version  = var.major_engine_version
  deletion_protection   = var.deletion_protection
  skip_final_snapshot   = var.skip_final_snapshot
  maintenance_window    = var.maintenance_window
  vpc_id                = module.network.vpc_id
  allocated_storage     = var.allocated_storage
  identifier_name       = var.identifier_name
  engine_version        = var.engine_version
  db_backup_name        = var.db_backup_name
  instance_class        = var.instance_class
  rotation_days         = var.rotation_days
  engine_name           = var.engine_name
  username             = var.username
  vpc_cidr              = var.vpc_cidr
  db_name               = var.db_name
  multi_az              = var.multi_az
  family                = var.family
  tags                  = local.tags
  depends_on = [
    module.network
  ]
}

module "compute" {
  source         = "../terraform-modules/compute"
  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
  tags           = local.tags
  depends_on = [
    module.network
  ]
}

module "container" {
  source                  = "../terraform-modules/container"
  tags                    = local.tags
  vpc_id                  = module.network.vpc_id
  test_ecr_repos         = local.test_ecr_repos
  aws_iam_policy_settings = local.aws_iam_policy_settings
  depends_on = [
    module.network
  ]
}

module "s3" {
  source  = "../terraform-modules/s3"
  tags    = local.tags
  buckets = local.buckets
  depends_on = [
    module.network
  ]
}

module "redis" {
  source               = "../terraform-modules/elasticache"
  tags                 = local.tags
  private_subnets      = module.network.private_subnets
  vpc_cidr             = var.vpc_cidr
  vpc_id               = module.network.vpc_id
  parameter_group_name = var.elasticache_parameter_group_name
  engine               = var.elasticache_engine
  engine_version       = var.elasticache_engine_version
  node_type            = var.elasticache_node_type
  depends_on = [
    module.network
  ]
}

module "bastion" {
  source              = "../terraform-modules/bastion"
  public_subnets      = module.network.public_subnets[0]
  vpc_id              = module.network.vpc_id
  https_listener_arns = module.compute.https_listener_arns
  tags                = local.tags
  depends_on = [
    module.network,
    module.compute
  ]
}

# module "cloudmap" {
#   source = "../terraform-modules/cloudmap"
#   tags   = local.tags
#   vpc_id = module.network.vpc_id
#   depends_on = [
#     module.network
#   ]
# }

# module "secrets-manager" {

#   source   = "lgallard/secrets-manager/aws"
#   for_each = local.secrets
#   secrets = {
#     "${each.key}" = {
#       description             = each.value.description
#       recovery_window_in_days = each.value.recovery_window_in_days
#       secret_string           = each.value.secret_string
#     }
#   }
#   tags = {
#     Name        = each.key
#     Environment = terraform.workspace
#     Terraform   = true
#   }
# }
