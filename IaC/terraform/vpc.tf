# resource "aws_vpc" "vpc" {
#   cidr_block = "10.0.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags = {
#     Name = "example-vpc"
#   }
# }

# resource "aws_subnet" "public_subnet" {
#   vpc_id            = aws_vpc.example_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   map_public_ip_on_launch = true
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "public-subnet"
#   }
# }

# resource "aws_subnet" "private_subnet" {
#   vpc_id            = aws_vpc.example_vpc.id
#   cidr_block        = "10.0.2.0/24"
#   map_public_ip_on_launch = false
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "private-subnet"
#   }
# }

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  #version = "4.0.2"
  version = "5.16.0"

  name = "vpc-ada-eks"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  public_subnets  = ["10.0.1.0/27", "10.0.1.32/27", "10.0.1.64/27"]
  private_subnets = ["10.0.2.0/27", "10.0.2.32/27", "10.0.2.64/27"]
  db_subnets      = ["10.0.3.0/27", "10.0.3.32/27", "10.0.3.64/27"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}
