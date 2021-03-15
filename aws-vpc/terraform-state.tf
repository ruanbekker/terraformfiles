terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-remote-state"
    key = "my-vpc/prod/base/terraform.tfstate"
    region = "eu-west-1"
    profile = "dev"
    shared_credentials_file = "~/.aws/credentials"
    dynamodb_table = "terraform-remote-state"
  }
}
