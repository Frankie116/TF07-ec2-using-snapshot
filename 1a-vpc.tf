# ---------------------------------------------------------------------------------------------------
# Library: /mygit/frankie116/library/v1.2
# create vpc
# ---------------------------------------------------------------------------------------------------

# req:
# 9b-random-string.tf - random_string.my-random-string.result
# variables.tf        - var.my-vpc-cidr-block
# variables.tf        - var.my-priv-subnet-cidr-blocks
# variables.tf        - var.my-priv-subnets-per-vpc
# variables.tf        - var.my-pub-subnet-cidr-blocks
# variables.tf        - var.my-pub-subnets-per-vpc


module "my-vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "2.44.0"
  cidr                   = var.my-vpc-cidr-block
  azs                    = data.aws_availability_zones.my-available-azs.names
  private_subnets        = slice(var.my-priv-subnet-cidr-blocks, 0, var.my-priv-subnets-per-vpc)
  public_subnets         = slice(var.my-pub-subnet-cidr-blocks, 0, var.my-pub-subnets-per-vpc)
  enable_nat_gateway     = true
  enable_vpn_gateway     = false
  tags                   = {
    Name                 = "my-vpc-${random_string.my-random-string.result}"
    Project              = var.my-project-name
    Environment          = var.my-environment
    Terraform            = "true"
  }
}

data "aws_availability_zones" "my-available-azs" {
  state                = "available"
}