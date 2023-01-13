resource "random_string" "userid" {
  count   = var.enabled == true ? 1 : 0

  length  = var.length
  special = var.special
  upper   = var.upper
}
