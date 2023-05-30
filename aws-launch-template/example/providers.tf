provider "aws" {
  region     = var.aws_region
  assume_role {
    role_arn = var.aws_role_arn
  }
}
