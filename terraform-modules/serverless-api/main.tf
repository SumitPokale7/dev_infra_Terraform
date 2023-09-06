
// lambda definition of the organisation api
module "lambda_organisation_api" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.api_base_name}-${var.api_environment}-organization"
  description   = "Lambda function for the organization api"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  source_path = var.function_package
  ignore_source_code_hash = true
  tags = local.tags
  timeout = var.lambda_timeout
  attach_policy = true
  policy = aws_iam_policy.iam_lambda_access_secrets_manager.arn
  attach_network_policy = true
  layers = [aws_lambda_layer_version.lambda_layer.arn]
  // the vpc config to let lambda access the rds instance => to be retrieved from the rds module output variables
  vpc_subnet_ids = var.rds_vpc_subnet_ids
  vpc_security_group_ids = var.rds_vpc_security_group_ids
  environment_variables = {
    RDS_SECRET_NAME = var.lambda_rds_connect_secret_name
  }

}
// the lambda layer containing the shared code
resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = var.function_package
  layer_name = "${var.api_base_name}-${var.api_environment}-shared-code"

  compatible_runtimes = ["nodejs14.x"]
 
}
// the lambda authorizer function 
module "lambda_authorizer" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.api_base_name}-${var.api_environment}-authorizer"
  description   = "lambda authorizer for custom api gateway auth flow"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  source_path =  var.function_package
  ignore_source_code_hash = true  
  tags = local.tags
  timeout = var.lambda_timeout
}

// the api gateway definition
resource "aws_api_gateway_rest_api" "test-serverless-api" {
  name = "${var.api_base_name}-${var.api_environment}"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  body = templatefile("${path.module}/openapi-serverless-definition.json", {
    lambda_organisation_api_arn = module.lambda_organisation_api.lambda_function_arn
    lambda_authorizer_arn = module.lambda_authorizer.lambda_function_arn
    region = var.region
  })
  tags = local.tags
}

// the api gateway deployment
resource "aws_api_gateway_deployment" "test-serverless-api" {
  rest_api_id = aws_api_gateway_rest_api.test-serverless-api.id

  lifecycle {
    create_before_destroy = true
  }
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.test-serverless-api.body))
  }
  
}
// the api gateway stage
resource "aws_api_gateway_stage" "test-serverless-api" {
  deployment_id = aws_api_gateway_deployment.test-serverless-api.id
  rest_api_id   = aws_api_gateway_rest_api.test-serverless-api.id
  stage_name    = "${var.api_environment}"
}
// allow the api gateway to invoke the lambda functions
resource "aws_lambda_permission" "lambda_permission_auth" {
  statement_id  = "${terraform.workspace}-AllowAPIInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_authorizer.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  //source_arn = "${aws_api_gateway_rest_api.test-serverless-api.execution_arn}/*/*/*"
}
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "${terraform.workspace}-AllowAPIInvokeOrganisation"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_organisation_api.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  //source_arn = "${aws_api_gateway_rest_api.test-serverless-api.execution_arn}/*/*/*"
}

// dns config of the api gateway
/*resource "aws_api_gateway_domain_name" "api-gateway-domain-name" {
  domain_name              = "api-stage.test.io"
  regional_certificate_arn = "arn:aws:acm:eu-north-1:677596581244:certificate/7d9f2f7b-8724-4742-aa01-bee8ae9d111e"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Example DNS record using Route53.
# Route53 is not specifically required; any DNS host can be used.
resource "aws_route53_record" "example" {
  name    = aws_api_gateway_domain_name.api-gateway-domain-name.domain_name
  type    = "A"
  zone_id = "Z04609191P2JEM8IX77Z3"

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.api-gateway-domain-name.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api-gateway-domain-name.regional_zone_id
  }
}

// map the api stage to the domain name
resource "aws_api_gateway_base_path_mapping" "api-gateway-base-path-mapping" {
  domain_name = aws_api_gateway_domain_name.api-gateway-domain-name.domain_name
  api_id = aws_api_gateway_rest_api.test-serverless-api.id
  stage_name  = aws_api_gateway_stage.test-serverless-api.stage_name
}*/







