resource "aws_api_gateway_rest_api" "test_rest_api" {
  for_each       = var.api_gateways
  api_key_source = each.value.api_key_source
  name           = each.key
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = var.tags
}

resource "aws_api_gateway_authorizer" "test_gateway_authorizer" {
  for_each                         = var.api_gateways
  rest_api_id                      = aws_api_gateway_rest_api.test_rest_api[each.key].id
  name                             = "${each.value.authorizer_name}-${terraform.workspace}"
  authorizer_result_ttl_in_seconds = 3600
  authorizer_uri                   = data.terraform_remote_state.lambda_authorizer.outputs.authorizer_arn
  # authorizer_uri                   = "arn:aws:apigateway:eu-north-1:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-north-1:677596581244:function:api-gateway-authorizer/invocations"
}

resource "aws_api_gateway_integration" "test_api_integration" {
  for_each    = var.api_gateways
  rest_api_id = aws_api_gateway_rest_api.test_rest_api[each.key].id
  resource_id = aws_api_gateway_resource.test_api_resource[each.key].id
  http_method = aws_api_gateway_method.test_api_method[each.key].http_method
  integration_http_method = "POST"
  type        = "AWS_PROXY"
  # cache_namespace      = "foobar"
  timeout_milliseconds = 29000
  uri = data.terraform_remote_state.lambda_authorizer.outputs.authorizer_arn
}

resource "aws_api_gateway_deployment" "test_api_deployment" {
  for_each    = var.api_gateways
  rest_api_id = aws_api_gateway_rest_api.test_rest_api[each.key].id

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_api_gateway_method.test_api_method,
    aws_api_gateway_integration.test_api_integration
  ]
}

resource "aws_api_gateway_resource" "test_api_resource" {
  for_each    = var.api_gateways
  parent_id   = aws_api_gateway_rest_api.test_rest_api[each.key].root_resource_id
  path_part   = "organizations"
  rest_api_id = aws_api_gateway_rest_api.test_rest_api[each.key].id
}

resource "aws_api_gateway_method" "test_api_method" {
  for_each         = var.api_gateways
  api_key_required = "true"
  authorization    = "CUSTOM"
  authorizer_id    = aws_api_gateway_authorizer.test_gateway_authorizer[each.key].id
  http_method      = "GET"

  request_parameters = {
    "method.request.path.organization_id" = "true"
  }

  resource_id = aws_api_gateway_resource.test_api_resource[each.key].id
  rest_api_id = aws_api_gateway_rest_api.test_rest_api[each.key].id
}


resource "aws_api_gateway_stage" "test_api_stage" {
  for_each      = var.api_gateways
  deployment_id = aws_api_gateway_deployment.test_api_deployment[each.key].id
  rest_api_id   = aws_api_gateway_rest_api.test_rest_api[each.key].id
  stage_name    = terraform.workspace
}

resource "aws_api_gateway_usage_plan" "test_usage_plan" {
  for_each = var.api_gateways
  name     = each.value.api_gateway_usage_plan
  api_stages {
    api_id = aws_api_gateway_rest_api.test_rest_api[each.key].id
    stage  = terraform.workspace
  }
  tags = var.tags
}

# resource "aws_api_gateway_method_response" "test_gateway_method" {
#   http_method = "GET"
#   resource_id = "f7wspv"

#   response_models = {
#     "application/json" = "Empty"
#   }

#   rest_api_id = "vggtp6aqia"
#   status_code = "200"
# }

# resource "aws_api_gateway_integration_response" "test_gateway_integration" {
#   http_method = "GET"
#   resource_id = "f7wspv"
#   rest_api_id = "vggtp6aqia"
#   status_code = "200"
# }
