#ports: 0 = all
#protocol: -1 = all
#===========================================================
# Security Grout To Allow All Local Traffic Within OpenVPN VPC
#===========================================================
resource "aws_default_security_group" "openvpn-default" {
  vpc_id = aws_vpc.openvpn.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    name = "openvpn-default"
  }
}
#===========================================================
# OpenVPN Security Group
#===========================================================
resource "aws_security_group" "openvpn" {
  name        = "openvpn_sg"
  description = "allow openvpn traffic"
  vpc_id      = aws_vpc.openvpn.id

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
    description = "https web interface"
    from_port = 945
    to_port = 945
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}