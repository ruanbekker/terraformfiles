resource random_id index {
  byte_length = 2
}

locals {
  subnet_ids_list = tolist(data.aws_subnet_ids.private.ids)
  subnet_ids_random_index = random_id.index.dec % length(data.aws_subnet_ids.private.ids)
  instance_subnet_id = local.subnet_ids_list[local.subnet_ids_random_index]
}
