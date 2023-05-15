resource "aws_route_table" "PRI-RT" {
  vpc_id = aws_vpc.main-vpc.id


  tags = {
    Name = "PRI-RTT"
  }
}



resource "aws_route" "PRI-rout" {
  route_table_id = aws_route_table.PRI-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.ng.id
}

resource "aws_route_table_association" "PRI-SN1-ASS" {
  subnet_id      = aws_subnet.PRI-SN1.id
  route_table_id = aws_route_table.PRI-RT.id
}

resource "aws_route_table_association" "PRI-SN2-ASS" {
  subnet_id      = aws_subnet.PRI-SN2.id
  route_table_id = aws_route_table.PRI-RT.id
}