resource "aws_kms_key" "state" {
  description = "Terraform S3 remote state KMS key."
  tags        = local.tags
}


resource "aws_kms_alias" "state" {
  name          = "alias/test/terraform-${terraform.workspace}/state"
  target_key_id = aws_kms_key.state.key_id
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "test-terraform-state-${terraform.workspace}"
  acl    = "private"

  versioning {


    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.state.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = local.tags
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "test-terraform-state-${terraform.workspace}"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}
