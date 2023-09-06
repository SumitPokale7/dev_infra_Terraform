resource "aws_acm_certificate" "certificate" {
  provider          = aws.alternate_region
  domain_name       = "test.io"
  validation_method = "DNS"
  subject_alternative_names = [
    "*.test.io",
    "test.app",
    "*.test.app",
  ]
}

resource "aws_acm_certificate_validation" "validate" {
  provider                = aws.alternate_region
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = aws_acm_certificate.certificate.domain_validation_options[*].resource_record_name
}
