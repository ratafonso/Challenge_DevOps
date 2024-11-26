resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = module.vpc.public_subnet.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = module.vpc.private_subnets.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table" "db_route_table" {
  vpc_id = module.vpc.db_subnets.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = module.vpc.private_subnets.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "db_subnet_association" {
  subnet_id      = module.vpc.db_subnets.id
  route_table_id = aws_route_table.db_route_table.id
}