module "vpc" {
  source                               = "terraform-aws-modules/vpc/aws"
  version                              = "3.14.2"
  name                                 = "${var.vpc_name} ${terraform.workspace}"
  cidr                                 = var.vpc_cidr
  azs                                  = var.azs
  private_subnets                      = var.private_subnets_cidrs
  public_subnets                       = var.public_subnet_cidrs
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_dns_support                   = var.enable_dns_support
  enable_nat_gateway                   = var.enable_nat_gateway
  single_nat_gateway                   = var.single_nat_gateway
  default_security_group_name          = "default-sg-${terraform.workspace}"
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true
  enable_flow_log                      = true
  manage_default_security_group        = true
  default_security_group_tags          = var.tags
  tags                                 = var.tags
}
