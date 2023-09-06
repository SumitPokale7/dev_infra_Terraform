// grant lambda access to secrets manager
resource "aws_iam_policy" "iam_lambda_access_secrets_manager" {
name         = "${var.api_base_name}-${var.api_environment}-lambda-s3-access"
path         = "/"
description  = "AWS IAM Policy for managing aws lambda secret manager access"
policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
            "Effect": "Allow",
            "Action": [
              "secretsmanager:GetSecretValue",
              "secretsmanager:DescribeSecret",
              "secretsmanager:ListSecretVersionIds",
              "secretsmanager:PutSecretValue",
              "secretsmanager:UpdateSecret",
              "secretsmanager:TagResource",
              "secretsmanager:UntagResource"
            ],
            "Resource": [
              "arn:aws:secretsmanager:*"
            ]
  }
 ]
}
EOF
}