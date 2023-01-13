variable "length" {
  default = 24
  type    = number
}


module "userid" {
  source = "../../modules/random-string"

  enabled = false
  length  = var.length
}
