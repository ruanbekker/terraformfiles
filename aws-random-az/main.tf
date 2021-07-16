data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = ["eu-west-1"]
  }
}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = 1
}

