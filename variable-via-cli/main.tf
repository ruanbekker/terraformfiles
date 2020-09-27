resource "null_resource" "this" {
  provisioner "local-exec" {
    command = "echo ${var.owner} > file.txt"
  }
}
