terraform {
  backend "s3" {
    encrypt = true
    bucket = "my-terraform-s3-state-bucket"
    key = "java-hello-world/dev/ecs/terraform.tfstate"
    region = "eu-west-1"
    profile = "dev"
    shared_credentials_file = "~/.aws/credentials"
    dynamodb_table = "my-terraform-state-table"
  }
}
