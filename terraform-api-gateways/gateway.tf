module "api-gateways" {
  source       = "../terraform-modules/api-gateways"
  api_gateways = local.api_gateways
  tags         = local.tags
}
