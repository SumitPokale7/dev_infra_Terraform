resource "aws_service_discovery_service" "test_service_discovery" {
  count = var.create_service_discovery ? 1 : 0
  name = "${var.service_name}-${terraform.workspace}"

  dns_config {
    namespace_id = data.terraform_remote_state.infrastructure.outputs.cloudmap_namespace_id

    dns_records {
      ttl  = 300
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# resource "aws_service_discovery_instance" "test_discovery_instance" {
#   count = var.create_cloudmap_service == true ? [1] : []
#   instance_id = aws_ecs_service.connectivity_service.name
#   service_id  = aws_service_discovery_service.test_service_discovery[each.key].id

#   attributes = {
#     AWS_INSTANCE_IPV4          = "10.217.11.176" 
#     AVAILABILITY_ZONE          = "${var.region}c"
#     REGION                     = var.region
#     AWS_INIT_HEALTH_STATUS     = "HEALTHY"
#     ECS_CLUSTER_NAME           = aws_ecs_service.connectivity_service.cluster
#     ECS_SERVICE_NAME           = aws_ecs_service.connectivity_service.name
#     ECS_TASK_DEFINITION_FAMILY = aws_ecs_service.connectivity_service.name
#   }
# }
