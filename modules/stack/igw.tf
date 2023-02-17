#internet gateway - allows instances with public IPs to access the internet
resource "aws_internet_gateway" "igw-OpenVPN" {
    vpc_id = aws_vpc.openvpn.id
    tags = {
        Name = "IGW-OpenVPN"
        VPC = "openvpn-vpc"
    }
}