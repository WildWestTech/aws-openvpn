#creating a vpc for openvpn
resource "aws_vpc" "openvpn-vpc" {
    cidr_block = "10.1.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
        Name = "openvpn-vpc"
    }
}
output "aws_vpc_main_id" {
    value = aws_vpc.openvpn-vpc.id
}

#create subnets for OpenVPN
resource "aws_subnet" "Public-1A-OpenVPN" {
    vpc_id = aws_vpc.openvpn-vpc.id
    cidr_block = "10.1.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-1A-OpenVPN"
    }
}
output "aws_subnet_Public-1A-OpenVPN_id" {
    value = aws_subnet.Public-1A-OpenVPN.id
}

resource "aws_subnet" "Private-1A-OpenVPN" {
    vpc_id = aws_vpc.openvpn-vpc.id
    cidr_block = "10.1.3.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "Private-1A-OpenVPN"
    }
}
output "aws_subnet_Private-1A-OpenVPN_id" {
    value = aws_subnet.Private-1A-OpenVPN.id
}

#create a route table for the private subnets
#default destination 10.1.0.0/16 targets local
#after we explicitly associate the two private subnets with this route table, 
#the remaining public subnets will continue to implicitly associate with the main route table
resource "aws_route_table" "Private-RT-OpenVPN" {
    vpc_id = aws_vpc.openvpn-vpc.id
        tags = {
        Name = "Private-RT-OpenVPN"
    }
}
output "aws_route_table_Private-RT-OpenVPN_id" {
    value = aws_route_table.Private-RT-OpenVPN.id
}

#explicitly associate the private route table with subnet Private-1A-OpenVPN
resource "aws_route_table_association" "Private-1A-OpenVPN" {
    subnet_id = aws_subnet.Private-1A-OpenVPN.id
    route_table_id = aws_route_table.Private-RT-OpenVPN.id
}

#internet gateway - allows instances with public IPs to access the internet
resource "aws_internet_gateway" "igw-OpenVPN" {
    vpc_id = aws_vpc.openvpn-vpc.id
    tags = {
        Name = "IGW-OpenVPN"
        VPC = "openvpn-vpc"
    }
}

#add route in main route table to the igw
resource "aws_default_route_table" "openvpn-vpc" {
    default_route_table_id = aws_vpc.openvpn-vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-OpenVPN.id
    }
}