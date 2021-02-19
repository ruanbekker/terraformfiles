provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-1"
  profile = "dev"
  shared_credentials_file = "~/.aws/credentials"
}

provider "null" {
  version = "~> 3.0"
}

provider "random" {
  version = "~> 3.0"
}
