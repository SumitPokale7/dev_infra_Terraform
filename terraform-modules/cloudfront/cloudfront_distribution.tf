resource "aws_cloudfront_origin_access_control" "test_origin_access_control" {
  name                              = var.oac_name
  description                       = "test access policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  aliases = var.cloudfront_aliases
  origin {
    domain_name              = data.aws_s3_bucket.s3_origin.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.test_origin_access_control.id
    origin_id                = data.aws_s3_bucket.s3_origin.bucket_regional_domain_name
    connection_attempts      = 3
    connection_timeout       = 10
  }

  enabled          = true
  is_ipv6_enabled  = true
  retain_on_delete = false
  http_version     = "http2and3"
  price_class      = "PriceClass_200"

  default_cache_behavior {
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

    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = "false"
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.certificate.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

resource "aws_s3_bucket_policy" "test_bucket_policy" {
  bucket = data.aws_s3_bucket.s3_origin.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
