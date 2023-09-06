resource "aws_ecs_service" "connectivity_service" {
  name            = "${var.service_name}-${terraform.workspace}"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.connectivity_task.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  enable_execute_command = true
  dynamic "service_registries" {
    for_each = var.create_service_discovery == true ? [1] : []
    content {
      registry_arn = aws_service_discovery_service.test_service_discovery[0].arn
    }
  }

  network_configuration {
    security_groups  = [var.ecs_sg_id]
    subnets          = var.private_subnets
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.create_target_group == true ? [1] : []
    content {
      container_name   = "${var.service_name}-nginx-${terraform.workspace}"
      container_port   = var.nginx_container_port
      target_group_arn = aws_alb_target_group.service_target_group[0].arn
    }
  }
  tags = var.tags
}

resource "aws_ecs_task_definition" "connectivity_task" {
  network_mode             = var.network_mode
  requires_compatibilities = [var.launch_type]
  family                   = "${var.service_name}-${terraform.workspace}"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  container_definitions    = var.container_definitions
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  tags = var.tags
}
