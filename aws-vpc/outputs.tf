output "aws_account_id" {
  value = module.networking.aws_account_id
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "vpc_cidr" {
  value = module.networking.vpc_cidr
}

output "public_subnets_id" {
  value = module.networking.public_subnets_id
}

output "private_subnets_id" {
  value = module.networking.private_subnets_id
}

output "public_subnets_cidr" {
  value = module.networking.public_subnets_cidr
}

output "private_subnets_cidr" {
  value = module.networking.private_subnets_cidr
}
