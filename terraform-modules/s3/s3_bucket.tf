data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "test_buckets" {
  for_each            = var.buckets
  bucket              = "${each.key}-${terraform.workspace}"
  object_lock_enabled = false

  grant {
    id          = data.aws_canonical_user_id.current.id
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }

  dynamic "cors_rule" {
    for_each = each.value.cors_rule == true ? [1] : []
    content {
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
      max_age_seconds = "0"
    }
  }

  dynamic "grant" {
    for_each = each.value.grant == true ? [1] : []
    content {
      permissions = ["READ_ACP", "WRITE"]
      type        = "Group"
      uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    }
  }

  dynamic "logging" {
    for_each = each.value.logging == true ? [1] : []
    content {
      target_bucket = "${each.key}-${terraform.workspace}"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }

      bucket_key_enabled = "false"
    }
  }

  versioning {
    enabled    = each.value.versioning_enabled
    mfa_delete = false
  } 

  tags = var.tags
}
