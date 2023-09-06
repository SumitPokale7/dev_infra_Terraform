resource "aws_elasticache_subnet_group" "test_redis_subnet_group" {
  description = "Subnet group for redis cluster"
  name        = "test-redis-${terraform.workspace}"
  subnet_ids  = var.private_subnets
}
