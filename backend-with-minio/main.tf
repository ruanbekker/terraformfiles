resource "aws_s3_bucket" "test" {
  bucket        = "my-test-bucket"
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_object" "object" {
    bucket = aws_s3_bucket.test.id
    key = "test.txt"
    source = "test.txt"
    etag = filemd5("test.txt")
}
