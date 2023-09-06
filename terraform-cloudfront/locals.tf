locals {
  
  cache_behavior_static = {
    allowed_methods            = ["GET", "HEAD"]
    cached_methods             = ["GET", "HEAD"]
    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    origin_request_policy_id   = "59781a5b-3903-41f3-afcb-af62929ccde1"
    response_headers_policy_id = "60669652-455b-4ae9-85a4-c4c02393f86c"
    target_origin_id           = data.aws_s3_bucket.s3_origin.bucket_regional_domain_name
    viewer_protocol_policy     = "redirect-to-https"
    smooth_streaming           = false
    compress                   = true
    default_ttl                = 0
    min_ttl                    = 0
    max_ttl                    = 0

    forwarded_values = {
      cookies = {
        forward = "none"
      }
      query_string = "false"
    }
  }

  cache_behavior_bot = {
    allowed_methods            = ["GET", "HEAD"]
    cached_methods             = ["GET", "HEAD"]
    target_origin_id           = data.aws_s3_bucket.s3_origin.bucket_regional_domain_name
    viewer_protocol_policy     = "redirect-to-https"
    smooth_streaming           = false
    compress                   = true
    default_ttl                = 0
    min_ttl                    = 0
    max_ttl                    = 0

    forwarded_values = {
        cookies = {
        forward = "none"
        }
        query_string = "false"
    }
  }

}