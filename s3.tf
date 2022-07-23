# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "bucket" {
  bucket = "prpr-terraform-state-backend" # s3 bucket name should be globally unique.
  versioning {
    enabled = true
  }
 server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}
