resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
    Environment = var.environment_name
    ManagedBy   = "terraform"
  }
}
