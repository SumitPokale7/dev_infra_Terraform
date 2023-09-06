resource "aws_ecr_repository" "test_ecr_repos" {
  for_each = var.test_ecr_repos
  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  image_tag_mutability = "MUTABLE"
  name                 = each.key
}