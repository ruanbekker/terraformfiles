provider "aws" {
  version                 = "~> 3.27"
  region                  = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "demo"
}
