variable "lambda_function_stage" {
  default = "prod"
}

variable "lambda_function_zip_name" {
  default = "package.zip"
}

variable "lambda_handler" {
  default = "index.handle"
}

variable "lambda_runtime" {
  default = "nodejs12.x"
}

variable "lambda_layer" {
  default = "commonlibs"
}

variable "application_name" {
  default = "greeters"
}
