resource "aws_vpc" "python-tdd-vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "python-tdd-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "python-tdd-subnet" {
  vpc_id = aws_vpc.python-tdd-vpc.id
  cidr_block = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "python-tdd-subnet"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "python-tdd-internet-gw" {
  vpc_id = aws_vpc.python-tdd-vpc.id

  tags = {
    Environment = var.environment
  }
}

resource "aws_route_table" "python-tdd-routing-table" {
  vpc_id = aws_vpc.python-tdd-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.python-tdd-internet-gw.id
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_route_table_association" "python-tdd-route-association" {
  subnet_id      = aws_subnet.python-tdd-subnet.id
  route_table_id = aws_route_table.python-tdd-routing-table.id
}