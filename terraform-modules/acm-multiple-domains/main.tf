resource "aws_route53_zone" "domain" {
  count = startswith(local.domain, "*") ? 0 : 1
  name  = local.domain
  # private_zone = false
}

resource "aws_route53_record" "tls-entry" {
  count           = startswith(local.domain, "*") ? 0 : 1
  allow_overwrite = true
  name            = local.name
  records         = [local.record]
  ttl             = local.ttl
  type            = local.type
  zone_id         = aws_route53_zone.domain[0].zone_id
}
