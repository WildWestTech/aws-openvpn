#create subnets for OpenVPN
resource "aws_subnet" "Public-1A-OpenVPN" {
    vpc_id = aws_vpc.openvpn.id
    cidr_block = "10.${var.second_octet}.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-1A-OpenVPN"
    }
}

resource "aws_subnet" "Private-1A-OpenVPN" {
    vpc_id = aws_vpc.openvpn.id
    cidr_block = "10.${var.second_octet}.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Private-1A-OpenVPN"
    }
}