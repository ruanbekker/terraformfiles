terraform {
  backend "s3" {
    region = "eu-west-1"
    profile = "master"
    encrypt = true
    bucket = "my-remote-state-terraform-bucket"
    key = "test-infra/dev/s3/terraform.tfstate"
    dynamodb_table = "terraform-remote-state-lock"
    shared_credentials_file = "~/.aws/credentials"
  }
}
