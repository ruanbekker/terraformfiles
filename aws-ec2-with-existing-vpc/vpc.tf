data "aws_vpc" "default" {
  default = true
  tags = {
    Tier = "main"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Tier = "public"
  }
}

resource "random_shuffle" "subnets" {
  input = tolist(data.aws_subnet_ids.public.ids)
  result_count = 1
}
