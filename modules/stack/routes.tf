#===================================================
# create a route table for the private subnets
# default destination 10.1.0.0/16 targets local
# after we explicitly associate the two private subnets with this route table, 
# the remaining public subnets will continue to implicitly associate with the main route table
#===================================================
# Route Table For Private Subnet
# Default local route 10.1.0.0/16
#===================================================
resource "aws_route_table" "OpenVPN-Private-RT" {
    vpc_id = aws_vpc.openvpn.id
    tags = {
        Name = "OpenVPN-Private-RT"
    }
}
#===================================================
# Route Table For Public Subnet
# Default local route 10.1.0.0/16
#===================================================
resource "aws_route_table" "OpenVPN-Public-RT" {
    vpc_id = aws_vpc.openvpn.id
    tags = {
        Name = "OpenVPN-Public-RT"
    }
}
#===================================================
# Explicitly associate the private route table with subnet Private-1A
#===================================================
resource "aws_route_table_association" "OpenVPN-Private-1A" {
    subnet_id = aws_subnet.Private-1A-OpenVPN.id
    route_table_id = aws_route_table.OpenVPN-Private-RT.id
}
#===================================================
# Explicitly associate the public route table with subnet Public-1A
#===================================================
resource "aws_route_table_association" "OpenVPN-Public-1A" {
    subnet_id = aws_subnet.Public-1A-OpenVPN.id
    route_table_id = aws_route_table.OpenVPN-Public-RT.id
}
#===================================================
# Route Internet Traffic In Public Subnet To Internet Gateway
#===================================================
resource "aws_route" "route_to_igw" {
  route_table_id = aws_route_table.OpenVPN-Public-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw-OpenVPN.id
}