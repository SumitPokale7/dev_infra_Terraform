locals {
  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }

  container_definitions = templatefile("services.tmpl", {
    region       = var.region,
    env          = terraform.workspace,
    port         = var.application_container_port[0],
    app_version  = var.app_version
    redis_url    = data.terraform_remote_state.infrastructure.outputs.redis_endpoint
    aws_elb_arn  = data.terraform_remote_state.infrastructure.outputs.alb_arn,
    account_id   = data.aws_caller_identity.account_id.account_id
    rds_host_url = data.terraform_remote_state.infrastructure.outputs.db_endpoint
  })
}
