
#https://openvpn.net/vpn-server-resources/amazon-web-services-ec2-byol-appliance-quick-start-guide/

#OpenVPN EC2 Instance - AMI
resource "aws_instance" "openvpn" {
    ami = "ami-037ff6453f0855c46"
    instance_type = "t2.micro"
    key_name = "openvpn-pem-keys"
    subnet_id = aws_subnet.Public-1A-OpenVPN.id
    vpc_security_group_ids = [aws_security_group.openvpn_sg.id]

    tags = {
        Name = "openvpn"
    }
}

resource "aws_security_group" "openvpn_sg" {
    name = "openvpn_sg"
    description = "allow openvpn traffic"
    vpc_id = aws_vpc.openvpn-vpc.id
    tags = {
        Name = "openvpn_sg"
    }

    ingress {
        description = "ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "https"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "https web interface"
        from_port = 943
        to_port = 943
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "IANA for OpenVPN"
        from_port = 1194
        to_port = 1194
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}