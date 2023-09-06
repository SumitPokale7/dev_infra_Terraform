module "alb" {
  source             = "../terraform-aws-alb"
  name               = "test-alb-${terraform.workspace}"
  load_balancer_type = var.lb_type
  vpc_id             = var.vpc_id
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.allow_traffic.id]
  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
    },
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = aws_acm_certificate.certificate.arn
      target_group_index = 0
    }
  ]

  tags = var.tags
  depends_on = [
    aws_security_group.allow_traffic
  ]
}
