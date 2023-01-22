terraform {
    backend "s3" {
        bucket          = "wildwesttech-terraform-backend-state-dev"
        key             = "terraform-openvpn-dev/terraform.tfstate"
        region          = "us-east-1"
        dynamodb_table  = "terraform-state-locking"
        encrypt         = true
        profile         = "251863357540_AdministratorAccess"
    }
}

#dev profile and region
provider "aws" {
    profile = "251863357540_AdministratorAccess"
    region  = "us-east-1"
}

module "stack" {
    source = "../../modules/stack"
}