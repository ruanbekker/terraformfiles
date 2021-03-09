locals {
  build_directory_path = "${path.module}/build"
  lambda_common_libs_layer_path = "${path.module}/files/layers/${var.lambda_layer}"
  lambda_common_libs_layer_zip_name = "${local.build_directory_path}/${var.lambda_layer}.zip"
}

resource "null_resource" "test_lambda_nodejs_layer" {
  provisioner "local-exec" {
    working_dir = "${local.lambda_common_libs_layer_path}/nodejs"
    command = "npm install"
  }

  triggers = {
    rerun_every_time = uuid()
  }
}

data "archive_file" "test_lambda_common_libs_layer_package" {
  type = "zip"
  source_dir = local.lambda_common_libs_layer_path
  output_path = local.lambda_common_libs_layer_zip_name

  depends_on = [null_resource.test_lambda_nodejs_layer]
}

resource "aws_lambda_layer_version" "test_lambda_nodejs_layer" {
  layer_name = var.lambda_layer
  filename = local.lambda_common_libs_layer_zip_name
  source_code_hash = data.archive_file.test_lambda_common_libs_layer_package.output_base64sha256
  compatible_runtimes = [var.lambda_runtime]
}
