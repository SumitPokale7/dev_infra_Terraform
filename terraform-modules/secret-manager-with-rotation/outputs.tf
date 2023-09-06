output "secret_arns" {
  value = values(aws_secretsmanager_secret.secret)[*].arn
}