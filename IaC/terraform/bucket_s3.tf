resource "aws_s3_bucket" "tfstate_bucket" {
  bucket        = "tfremotestate-eu-central-1" # Change to a unique bucket name
  acl           = "private"
  force_destroy = true # Optional: Allows destroying the bucket even if it contains objects

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
}


resource "aws_dynamodb_table" "tfstate_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  hash_key = "LockID"
}
