output "target_group_arns" {
  value = module.alb.target_group_arns
}

output "target_group_attachments" {
  value = module.alb.target_group_attachments
}

output "https_listener_arns" {
  value = module.alb.https_listener_arns 
}

output "aws_acm_certificate" {
  value = aws_acm_certificate.certificate.arn
}

output "alb_arn" {
  value = module.alb.lb_arn
}

# output "zone_id" {
#   value = module.acm-multiple-domains["test.io"]
# }

output "domain_record" {
  value = module.acm-multiple-domains
}