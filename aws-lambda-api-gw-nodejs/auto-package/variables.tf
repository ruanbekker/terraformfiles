variable "test_lambda_function_stage" {
  default = "prod"
}

variable "lambda_function_zip_name" {
  default = "package.zip"
}

variable "lambda_function_name" {
  default = "test-lambda"
}

variable "lambda_handler" {
  default = "index.handle"
}

variable "lambda_runtime" {
  default = "nodejs12.x"
}

variable "lambda_layer" {
  default = "commonLibs"
}
