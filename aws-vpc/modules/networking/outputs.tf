output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnets_id" {
  value = [aws_subnet.public_subnet.*.id]
}

output "private_subnets_id" {
  value = [aws_subnet.private_subnet.*.id]
}

output "public_subnets_cidr" {
  value = var.public_subnets_cidr
}

output "private_subnets_cidr" {
  value = var.private_subnets_cidr
}

output "default_sg_id" {
  value = aws_security_group.default.id
}

output "security_groups_ids" {
  value = [aws_security_group.default.id]
}

output "public_route_table" {
  value = aws_route_table.public.id
}
