resource "aws_eip" "elastic-ip" {
  # instance = aws_instance.web.id
  vpc      = true
}
resource "aws_nat_gateway" "ng" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id     = aws_subnet.PUB-SN1.id

  tags = {
    Name = "NAT-GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}