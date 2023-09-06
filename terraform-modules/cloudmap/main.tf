resource "aws_service_discovery_private_dns_namespace" "test_private_dns_namespace" {
  name        = "ecs-internal"
  description = "cloudmap"
  vpc         = var.vpc_id
  tags        = var.tags 
}

# resource "aws_service_discovery_service" "test_service_discovery" {
#   name = "example"

#   dns_config {
#     namespace_id = aws_service_discovery_private_dns_namespace.test_private_dns_namespace.id

#     dns_records {
#       ttl  = 300
#       type = "A"
#     }

#     routing_policy = "MULTIVALUE"
#   }

#   health_check_custom_config {
#     failure_threshold = 1
#   }
# }