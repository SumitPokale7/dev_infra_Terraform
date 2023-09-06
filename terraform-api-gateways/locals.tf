locals {
  tags = {
    Terraform   = "true"
    Environment = terraform.workspace
  }

  api_gateways = {
    "test-api" = {
      authorizer_name        = "test-api-gateway-authorizer"
      api_gateway_usage_plan = "Organization Plus"
      api_key_source         = "AUTHORIZER"
      path_part              = ["organizations"]
    }
  }
}
