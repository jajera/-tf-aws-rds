# create vpc
resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "tf-vpc-example"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

# create ig
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name    = "tf-ig-example"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

# create rt
resource "aws_route_table" "public1" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name    = "tf-rt-public1"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_route_table" "public2" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name    = "tf-rt-public2"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_route_table" "public3" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name    = "tf-rt-public3"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name    = "tf-rt-private1"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name    = "tf-rt-private2"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_route_table" "private3" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
  }

  tags = {
    Name    = "tf-rt-private3"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

# create subnet
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name    = "tf-subnet-public1"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name    = "tf-subnet-private1"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name    = "tf-subnet-public2"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name    = "tf-subnet-private2"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_subnet" "public3" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name    = "tf-subnet-public3"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_subnet" "private3" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-southeast-1c"

  tags = {
    Name    = "tf-subnet-private3"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_db_subnet_group" "db" {
  name = "db"
  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id,
    aws_subnet.private3.id
  ]

  tags = {
    Name    = "tf-subnet-group-db"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

# set rt association
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public1.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public2.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private2.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public3.id
}

resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private3.id
}

resource "aws_eip" "example" {
  domain = "vpc"

  tags = {
    Name    = "tf-eip-example"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.example.id
  subnet_id     = aws_subnet.public1.id

  depends_on = [
    aws_internet_gateway.example
  ]

  tags = {
    Name    = "tf-ngw-example"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}

resource "aws_security_group" "http_alb" {
  name        = "tf-sg-example-http_alb"
  description = "Security group for example resources to allow alb access to http"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "tf-sg-example_http_alb"
    Owner   = "John Ajera"
    UseCase = var.use_case
  }
}
