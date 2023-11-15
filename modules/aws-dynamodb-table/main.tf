resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  dynamic "attribute" {
    for_each = var.enable_hash_key ? [var.hash_key] : []
    content {
      name = attribute.value
      type = "S"
    }
  }

  dynamic "attribute" {
    for_each = var.enable_range_key ? [var.range_key] : []
    content {
      name = attribute.value
      type = "S"
    }
  }

  hash_key = var.enable_hash_key ? var.hash_key : null
  range_key = var.enable_range_key ? var.range_key : null

  tags = var.tags
}
