terraform {
    backend "s3" {
        bucket          = "wildwesttech-terraform-backend-state-openvpn"
        key             = "terraform-openvpn/terraform.tfstate"
        region          = "us-east-1"
        dynamodb_table  = "terraform-state-locking"
        encrypt         = true
        profile         = "785888383526_AdministratorAccess"
    }
}

#dev profile and region
provider "aws" {
    profile = "785888383526_AdministratorAccess"
    region  = "us-east-1"
}

module "stack" {
    source = "../../modules/stack"
    second_octet = 1
}