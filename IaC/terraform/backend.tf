#Configure the Terraform backend to use an S3 bucket for storing state file
terraform {
  backend "s3" {
    bucket         = "tfremotestate-eu-central-1"
    key            = "terraform/deployment.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tfremotestate"
    profile        = "ada-deployment-acc"
    encrypt        = true
  }
}