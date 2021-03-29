terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform--remote-state-bucket" 
    key = "terraform/ecs/dev/ecs/ec2/terraform.tfstate"
    region = "eu-west-1"
    profile = "dev"
    shared_credentials_file = "~/.aws/credentials"
    dynamodb_table = "terraform-remote-state"
  }
}
