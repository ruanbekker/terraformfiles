output "kms_key_arn" {
    value = data.aws_kms_alias.kms_key.arn
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.remote_state.arn
}

output "dynamodb_table_arn" {
    value = aws_dynamodb_table.remote_state_lock.arn
}
