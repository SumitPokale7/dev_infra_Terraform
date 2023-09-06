output "api_gateway_arn" {
  value = tomap({
    for x in aws_api_gateway_rest_api.test_rest_api :
    x.name => x.arn 
  })
}