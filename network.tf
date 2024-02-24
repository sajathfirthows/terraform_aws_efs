resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
}
resource "aws_internet_gateway" "IG-new" {
  vpc_id    = aws_vpc.my_vpc.id

  tags      = {
    Name    = "My-VPC"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_1_cidr
  availability_zone = var.az_1

  tags = {
    Name = "main_subnet1"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG-new.id
  }

  tags       = {
    Name     = "public route table"
  }
}

# associate public subnet az1 to "public route table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_1_route_table_association" {
  subnet_id           = aws_subnet.subnet_1.id
  route_table_id      = aws_route_table.public_route_table.id
}
