terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-bucket"
    key = "eu-west-1/myproject/prod/terraform.tfstate"
    region = "eu-west-1"
    profile = "terraform"
    shared_credentials_file = "~/.aws/credentials"
    dynamodb_table = "terraform-state-table"
  }
}
