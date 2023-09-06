resource "aws_acm_certificate" "certificate" {
  domain_name       = "test.io"
  validation_method = "DNS"
  subject_alternative_names = [
    "*.test.io",
    "test.app",
    "*.test.app",
  ]
}

module "acm-multiple-domains" {
  for_each = { for domain in aws_acm_certificate.certificate.domain_validation_options : domain.domain_name => domain }

  source          = "../acm-multiple-domains"
  certificate_arn = aws_acm_certificate.certificate.arn
  domain          = each.key
  name            = each.value.resource_record_name
  type            = each.value.resource_record_type
  record          = each.value.resource_record_value
  ttl             = 60
}

resource "aws_acm_certificate_validation" "validate" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for domain in module.acm-multiple-domains : domain.record[0].fqdn]
}
