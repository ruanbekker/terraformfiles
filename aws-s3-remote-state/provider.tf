provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-1"
  profile = "master"
  shared_credentials_file = "~/.aws/credentials"
}
