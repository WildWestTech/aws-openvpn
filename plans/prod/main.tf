terraform {
    backend "s3" {
        bucket          = "wildwesttech-terraform-backend-state-prod"
        key             = "terraform-openvpn-prod/terraform.tfstate"
        region          = "us-east-1"
        dynamodb_table  = "terraform-state-locking"
        encrypt         = true
        profile         = "264940530023_AdministratorAccess"
    }
}

#prod profile and region
provider "aws" {
    profile = "264940530023_AdministratorAccess"
    region  = "us-east-1"
}

module "stack" {
    source = "../../modules/stack"
}