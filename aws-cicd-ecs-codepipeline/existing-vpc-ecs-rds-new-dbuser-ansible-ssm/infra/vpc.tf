data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Tier = "private"
  }
}

resource "random_shuffle" "subnets" {
  input = tolist(data.aws_subnet_ids.private.ids)
  result_count = 3
}

