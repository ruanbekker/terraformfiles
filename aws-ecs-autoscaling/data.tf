data "aws_vpc" "vpc" {
  default = true
  tags = {
    Name = "main"
  }
}

data "aws_availability_zones" "az" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.aws_region]
  }
}

data "aws_subnet" "public_1" {
  availability_zone = data.aws_availability_zones.az.names[0]
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Tier = var.public_network_tier
  }
}

data "aws_subnet" "public_2" {
  availability_zone = data.aws_availability_zones.az.names[1]
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Tier = var.public_network_tier
  }
}

data "aws_subnet" "public_3" {
  availability_zone = data.aws_availability_zones.az.names[2]
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Tier = var.public_network_tier
  }
}

data "aws_subnet" "private_1" {
  availability_zone = data.aws_availability_zones.az.names[0]
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Tier = var.private_network_tier
  }
}

data "aws_subnet" "private_2" {
  availability_zone = data.aws_availability_zones.az.names[1]
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Tier = var.private_network_tier
  }
}

data "aws_subnet" "private_3" {
  availability_zone = data.aws_availability_zones.az.names[2]
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    Tier = var.private_network_tier
  }
}

data "aws_nat_gateway" "vpc" {
  tags = {
    Name = var.nat_gateway_name
  }
}

data "aws_instance" "vpn" {
  filter {
    name   = "tag:terraform_identifier"
    values = ["openvpn-instance"]
  }
}
