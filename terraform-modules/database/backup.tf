resource "aws_iam_role" "test_backup_role" {
  name               = "${var.db_backup_name}-${terraform.workspace}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "test_backup_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.test_backup_role.name
}

resource "aws_kms_key" "test_backup_kms_key" {
  description             = "test DB Backup"
}

resource "aws_backup_vault" "test_backup_vault" {
  kms_key_arn = aws_kms_key.test_backup_kms_key.arn
  name        = "${var.db_backup_name}-${terraform.workspace}"
}

resource "aws_backup_plan" "test_backup_plan" {
  name = "${var.db_backup_name}-${terraform.workspace}"

  rule {
    target_vault_name = aws_backup_vault.test_backup_vault.name
    schedule          = "cron(0 3 * * ? *)"
    rule_name         = "${var.db_backup_name}-${terraform.workspace}"

    lifecycle {
      delete_after = 30
    }
  }
  tags = var.tags
}

resource "aws_backup_selection" "test_backup_selection" {
  plan_id      = aws_backup_plan.test_backup_plan.id
  iam_role_arn = aws_iam_role.test_backup_role.arn
  name         = "${var.db_backup_name}-${terraform.workspace}"

  resources = [
    module.db.db_instance_arn
  ]
}
