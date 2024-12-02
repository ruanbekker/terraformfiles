# terraform-for-loops

## Examples

### Locals

Loops through local values to determine its value:

```hcl
locals {
  all_databases = {
    db_a = {
      schema_name = "example_a"
      role_name   = "role_a"
    },
    db_b = {
      schema_name = "example_b"
      role_name   = "role_b"
    },
  }
  standard_user = { for database, value in local.all_databases: database => { (value.schema_name) = { "*" = ["SELECT"] } } }
  power_user    = { for database, value in local.all_databases: database => { (value.schema_name) = { "*" = ["SELECT", "UPDATE", "DELETE", "CREATE"]} } }
}
```
