resource "null_resource" "this" {
  for_each = {
    a = "one"
    b = "two"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "${each.key}: '${each.value}'" >> results.yml
    EOT
  }

}
