resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.cloudwatch_group}-${terraform.workspace}"
  tags = var.tags
}


resource "aws_ecs_cluster" "test_ecs_cluster" {
  name               = "test-${terraform.workspace}"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
  tags = var.tags
}
