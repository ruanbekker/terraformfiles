data "aws_kms_alias" "kms_key" {
  name = "alias/${var.kms_key}"
}

resource "aws_s3_bucket" "remote_state" {
  bucket        = var.s3_remote_state_bucket_name
  acl           = "private"
  force_destroy = false
  
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.aws_kms_alias.kms_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_dynamodb_table" "remote_state_lock" {
  name           = var.dynamodb_remote_state_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.dynamodb_remote_state_table_name
    ManagedBy   = "terraform"
  }

}
