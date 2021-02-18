variable "kms_key" {
    type    = string
    default = "aws/s3"
}

variable "s3_remote_state_bucket_name" {
    type    = string
    default = ""
}

variable "dynamodb_remote_state_table_name" {
    type    = string
    default = ""
}
