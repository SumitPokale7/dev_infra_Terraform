output "bucket_arns" {
#   value = {for k, v in aws_s3_bucket.test_buckets: k => v.arn}
    value = values(aws_s3_bucket.test_buckets)[*].arn
}