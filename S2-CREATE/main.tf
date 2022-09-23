resource "aws_s3_bucket" "b" {
  bucket = var.bucket-name

  tags = {
    Name        = "test"
    Environment = var.env
  }
}