resource "aws_subnet" "PRI-SN1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.PRI-SN1-cider
  availability_zone = "us-east-1a"
  tags = {
    Name = "PRI-SN1"
  }
}


resource "aws_subnet" "PRI-SN2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.PRI-SN2-cider
  availability_zone = "us-east-1b"
  tags = {
    Name = "PRI-SN2"
  }
}



resource "aws_subnet" "PUB-SN1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.PUB-SN1-cider
  availability_zone = "us-east-1a"
  tags = {
    Name = "PUB-SN1"
  }
}



resource "aws_subnet" "PUB-SN2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = var.PUB-SN2-cider
  availability_zone = "us-east-1b"
  tags = {
    Name = "PUB-SN2"
  }
}