terraform {
  backend "s3" {
    region = "eu-west-1"
    profile = "test"
    encrypt = true
    bucket = "my-terraform-remote-state"
    key = "test-s3/terraform.tfstate"
    dynamodb_table = "terraform-remote-state"
    shared_credentials_file = "~/.aws/credentials"
  }
}
