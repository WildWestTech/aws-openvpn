#=================================================
# OpenVPN EC2 Instance - AMI
# https://openvpn.net/vpn-server-resources/amazon-web-services-ec2-byol-appliance-quick-start-guide/
# This will require console work, which is the primary reason this section of the project is considered a "pet".
# Keys were created in the console and downloaded to my home directory. 
# I don't want to deal with creating and re-creating them for a lab.
#=================================================
resource "aws_instance" "openvpn" {
    ami = "ami-037ff6453f0855c46"
    instance_type = "t2.micro"
    key_name = "openvpn-pem-keys"
    subnet_id = aws_subnet.Public-1A-OpenVPN.id
    vpc_security_group_ids = [aws_security_group.openvpn.id]
    tags = {
        Name = "openvpn"
    }
}