resource "aws_eip" "nat-gateway-1A-OpenVPN" {
  vpc      = true
  tags     = {
    name     = "nat-gateway-1A-OpenVPN"
  }
}

resource "aws_nat_gateway" "nat-gateway-1A-OpenVPN" {
  allocation_id = aws_eip.nat-gateway-1A-OpenVPN.id
  subnet_id     = aws_subnet.Public-1A-OpenVPN.id
  tags = {
    Name = "gw NAT 1A OpenVPN"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw-OpenVPN]
}

resource "aws_route" "nat_gateway_route_1A_OpenVPN" {
  route_table_id          = aws_route_table.OpenVPN-Private-RT.id
  destination_cidr_block  = "0.0.0.0/0"
  nat_gateway_id          = aws_nat_gateway.nat-gateway-1A-OpenVPN.id
}