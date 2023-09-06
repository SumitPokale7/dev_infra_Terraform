# data "aws_s3_bucket" "s3_ses" {
#   bucket = "testbenifyemails-${terraform.workspace}"
# }

data "aws_caller_identity" "account_id" {}

# data "aws_iam_policy_document" "s3_policy" {
#   statement {
#     actions   = ["s3:PutObject"]
#     resources = ["${data.aws_s3_bucket.s3_ses.arn}/*"]

#     principals {
#       type        = "Service"
#       identifiers = ["ses.amazonaws.com"]
#     }
#     condition {
#       test     = "StringEquals"
#       variable = "aws:Referer"
#       values   = ["${aws_ses_receipt_rule_set.test_ses_receipt_rule_set.arn}","${data.aws_caller_identity.account_id.account_id}"]
#     }
#   }
# }
