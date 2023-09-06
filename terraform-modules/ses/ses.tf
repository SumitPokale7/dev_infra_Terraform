resource "aws_ses_domain_identity" "example" {
  domain = var.domain_identity
}

resource "aws_ses_receipt_rule_set" "test_ses_receipt_rule_set" {
  provider      = aws.alternate_region
  rule_set_name = "Benify"
}

# resource "aws_ses_email_identity" "test_ses_email_identity" {
#   email = var.email_identity
# }

# resource "aws_ses_receipt_rule" "test_ses_receipt_rule" {
#   provider      = aws.alternate_region
#   enabled       = "true"
#   name          = "BenifyEmailParser"
#   recipients    = ["benify@${var.domain_identity}"]
#   rule_set_name = aws_ses_receipt_rule_set.test_ses_receipt_rule_set.rule_set_name

#   s3_action {
#     bucket_name       = data.aws_s3_bucket.s3_ses.bucket
#     object_key_prefix = "new"
#     position          = "1"
#   }

#   scan_enabled = "true"
#   tls_policy   = "Optional"
# }

# resource "aws_s3_bucket_policy" "test_bucket_policy" {
#   bucket = data.aws_s3_bucket.s3_ses.id
#   policy = data.aws_iam_policy_document.s3_policy.json
# }