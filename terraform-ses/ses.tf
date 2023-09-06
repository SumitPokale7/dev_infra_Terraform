module "ses" {
  source          = "../terraform-modules/ses"
  # email_identity  = var.email_identity
  domain_identity = var.domain_identity
}
