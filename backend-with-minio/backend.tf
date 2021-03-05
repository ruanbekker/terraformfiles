terraform {
  backend "s3" {
    endpoint = "http://127.0.0.1:9000"
    bucket= "terraform-remote-state"
    key = "demo/terraform.tfstate"
    region = "us-east-1"
    profile = "minio"
    shared_credentials_file = "~/.aws/credentials"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
  }
}
