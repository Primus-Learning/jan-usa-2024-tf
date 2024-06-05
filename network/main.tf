resource "aws_vpc" "primus-vpc" {
  cidr_block = var.cidr_block
}


resource "aws_subnet" "primus-public-subnet" {
  vpc_id            = aws_vpc.primus-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.av-zone-a

  tags = {
    Name = "primus-public-subnet"
  }
}


resource "aws_subnet" "primus-private-subnet" {
  vpc_id            = aws_vpc.primus-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.av-zone-c

  tags = {
    Name = "primus-private-subnet"
  }
}


resource "aws_internet_gateway" "primus-igw" {
  vpc_id = aws_vpc.primus-vpc.id

  tags = {
    Name = "primus-igw"
  }
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.primus-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primus-igw.id
  }


  tags = {
    Name = "pub-rt"
  }
}

resource "aws_route_table_association" "pub-rt-assoc" {
  subnet_id      = aws_subnet.primus-public-subnet.id
  route_table_id = aws_route_table.pub-rt.id
}