resource "aws_elasticache_replication_group" "test_redis_replication_group" {
  at_rest_encryption_enabled = true
  auto_minor_version_upgrade = true
  automatic_failover_enabled = true

  # cluster_mode {
  #   num_node_groups         = 1
  #   replicas_per_node_group = 1
  # }

  data_tiering_enabled = false
  description          = "replication group for elaticache cluster"
  engine               = var.engine
  engine_version       = var.engine_version

  log_delivery_configuration {
    destination      = "redis-${terraform.workspace}"
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  multi_az_enabled              = true
  node_type                     = var.node_type
  num_cache_clusters            = 2
  parameter_group_name          = var.parameter_group_name
  port                          = var.port
  replication_group_id          = "test-redis-${terraform.workspace}"
  security_group_ids            = [aws_security_group.allow_redis.id]
  snapshot_retention_limit      = "1"
  subnet_group_name             = aws_elasticache_subnet_group.test_redis_subnet_group.name
  transit_encryption_enabled    = "true"
}
