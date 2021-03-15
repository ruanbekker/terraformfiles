resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  aws_availability_zones = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
}

module "networking" {
  source = "./modules/networking"

  aws_region           = var.aws_region
  environment_name     = var.environment_name
  account_role         = var.account_role
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.aws_availability_zones
}
