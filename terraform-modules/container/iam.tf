data "aws_iam_policy_document" "ecs_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_task_role_document" {
  # statement {
  #   sid = "EcsTaskServiceAccess"
  #   actions = [
  #     "s3:*",
  #     "secretsmanager:*",
  #     "acm:*",
  #     "ses:*",
  #     "elasticloadbalancing:*"
  #     ]
  #   resources = ["*"]
  # }
  dynamic "statement" {
    for_each = var.aws_iam_policy_settings

    content {
      effect = "Allow"
      actions = statement.value.actions
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_policy" "ecs_task_role_policy" {
  name   = "ecs-task-role-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs_task_role_document.json
}

resource "aws_iam_role" "ecs_task_role" {
  name                = "ecs-task-role-${terraform.workspace}"
  assume_role_policy  = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.ecs_task_role_policy.arn]
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name                = "ecs-task-execution-role-${terraform.workspace}"
  assume_role_policy  = data.aws_iam_policy_document.ecs_task_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}
