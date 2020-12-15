resource "aws_vpc" "vpc-demo" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-demo"
  }
}

resource "aws_subnet" "public-subnet-1a" {
  vpc_id     = aws_vpc.vpc-demo.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public Subnet 1a"
  }
}

resource "aws_subnet" "public-subnet-1b" {
  vpc_id     = aws_vpc.vpc-demo.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public Subnet 1b"
  }
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc-demo.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "route-table-1" {
    vpc_id = aws_vpc.vpc-demo.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc-igw.id
    }

    tags = {
        Name = "Public subnets Route Table"
    }
}

resource "aws_route_table_association" "public-subnet-1a" {
    subnet_id = aws_subnet.public-subnet-1a.id
    route_table_id = aws_route_table.route-table-1.id
}

resource "aws_route_table_association" "public-subnet-1b" {
    subnet_id = aws_subnet.public-subnet-1b.id
    route_table_id = aws_route_table.route-table-1.id
}