#creating a vpc for openvpn
resource "aws_vpc" "openvpn" {
    cidr_block = "10.${var.second_octet}.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
        Name = "openvpn-vpc"
    }
}