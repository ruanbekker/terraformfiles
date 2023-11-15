module "mytable" {
  source = "../"

  table_name       = "my-table"
  billing_mode     = "PROVISIONED"
  enable_hash_key  = true
  enable_range_key = false
  hash_key         = "username"
  read_capacity    = 2
  write_capacity   = 1

  tags = {
    "Name"        = "my-table"
    "Environment" = "test"
  }
}

output "mytable" {
  value = module.mytable.table_arn
}
