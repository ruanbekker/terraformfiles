provider "aws" {
    region = "us-east-1"
    profile = "minio"
    shared_credentials_file = "~/.aws/credentials"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_requesting_account_id = true
    s3_force_path_style = true
    endpoints {
        s3 = "http://127.0.0.1:9000"
    }
}
