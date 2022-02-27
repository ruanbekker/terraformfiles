resource "aws_s3_bucket" "this" {
  bucket = "my-bucket"
  
  tags   = {
    Name  = "my-bucket"
    Owner = "devops"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
