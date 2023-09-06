module "cloudfront" {
  source             = "../terraform-modules/cloudfront"
  cloudfront_aliases = var.cloudfront_aliases
  tags               = var.tags
  cache_behavior     = local.cache_behavior_static
  bucket_name        = "test-${terraform.workspace}"
  name               = "cloudfront-${terraform.workspace}"
  oac_name           = "test-origin-access-control-${terraform.workspace}"
}

module "bot-cloudfront" {
  source             = "../terraform-modules/cloudfront"
  cloudfront_aliases = var.cloudfront_aliases_bot
  tags               = var.tags
  cache_behavior     = local.cache_behavior_bot
  bucket_name        = "testbot-${terraform.workspace}"
  name               = "bot-cloudfront-${terraform.workspace}"
  oac_name           = "bot-test-origin-access-control-${terraform.workspace}"
}
