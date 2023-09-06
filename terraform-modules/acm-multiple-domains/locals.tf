locals {
  certificate_arn = var.certificate_arn
#   domain          = replace(var.domain,"*.","")
  domain          = var.domain
  name            = var.name
  type            = var.type
  record          = var.record
  ttl             = var.ttl
}