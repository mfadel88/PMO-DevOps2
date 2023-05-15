resource "aws_route_table" "PUB-RT" {
  vpc_id = aws_vpc.main-vpc.id

  tags = {
    Name = "PUB-RT"
  }
}



resource "aws_route" "PUB-rout" {
  route_table_id = aws_route_table.PUB-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "PUB-SN1-ASS" {
  subnet_id      = aws_subnet.PUB-SN1.id
  route_table_id = aws_route_table.PUB-RT.id
}

resource "aws_route_table_association" "PUB-SN2-ASS" {
  subnet_id      = aws_subnet.PUB-SN2.id
  route_table_id = aws_route_table.PUB-RT.id
}