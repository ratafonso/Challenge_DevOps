# No credentials explicitly set here because they come from either the
# environment or the global credentials file.

# Configure the AWS Provider with assume role for the IT account
provider "aws" {
  region = var.region
  profile = "ada-p"
  default_tags {
    tags = local.common_tags
  }
}