variable "length" {
  default = 24
  type    = number
}


module "userid" {
  source = "../../modules/random-string"

  enabled = true
  length  = var.length
}

output "userid" {
  value = module.userid.userid[0]
}
