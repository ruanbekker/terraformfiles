module "s3" {
  source = "./modules/s3"
  bucket_name = "${terraform.workspace}-${var.bucket_name}"
  environment_name = terraform.workspace
}
