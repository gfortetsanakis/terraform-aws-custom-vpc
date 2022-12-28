resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "custom-vpc"
  }
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "vpc_public_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.public_subnets[count.index]["cidr_block"]
  map_public_ip_on_launch = true
  availability_zone       = var.public_subnets[count.index]["availability_zone"]

  tags = {
    Name = "custom-vpc-public-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "public-subnet-route-table"
  }
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.public_rt.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.vpc_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "vpc_private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnets[count.index]["cidr_block"]
  availability_zone = var.private_subnets[count.index]["availability_zone"]

  tags = {
    Name = "custom-vpc-private-subnet-${count.index + 1}"
  }
}

resource "aws_default_route_table" "private_rt" {
  count                  = length(var.private_subnets) > 0 ? 1 : 0
  default_route_table_id = aws_vpc.custom_vpc.default_route_table_id

  tags = {
    Name = "private-subnet-route-table"
  }
}

resource "aws_vpc_endpoint" "s3_gateway_endpoint" {
  count           = length(var.private_subnets) > 0 && var.create_s3_gateway ? 1 : 0
  vpc_id          = aws_vpc.custom_vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_default_route_table.private_rt[count.index].id]

  tags = {
    Name = "s3-gateway-endpoint"
  }
}