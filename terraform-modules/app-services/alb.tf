resource "aws_alb_target_group" "service_target_group" {
  count       = var.create_target_group ? 1 : 0
  name        = "${var.service_name}-target-group"
  target_type = "ip"
  port        = var.nginx_container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/healthcheck"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-299"
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_listener_rule" "services_listener_rule" {
  count = var.create_target_group ? 1 : 0
  action {
    order            = "1"
    target_group_arn = aws_alb_target_group.service_target_group[0].arn
    type             = "forward"
  }

  listener_arn = var.https_listener_arns[0]

  condition {
    host_header {
      values = var.domain
    }
  }
  tags = var.tags
}

resource "null_resource" "listener_default_action" {
  count = var.create_default_rule ? 1 : 0
  provisioner "local-exec" {
    command = "aws elbv2 modify-listener --listener-arn ${var.https_listener_arns[0]} --default-action Type=forward,TargetGroupArn=${aws_alb_target_group.service_target_group[0].arn}"
  }
}

resource "aws_alb_listener_rule" "additional_domains" {
  count = var.create_additional_domains ? 1 : 0
  action {
    order            = "1"
    target_group_arn = aws_alb_target_group.service_target_group[0].arn
    type             = "forward"
  }
  listener_arn = var.https_listener_arns[0]

  condition {
    host_header {
      values = var.additional_domains
    }
  }
}
