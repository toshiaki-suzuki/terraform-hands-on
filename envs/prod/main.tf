module "vpc" {
  source  = "../../modules/vpc"
}

module "sg" {
  source  = "../../modules/sg"
}

module "keypair" {
  source  = "../../modules/keypair"
}

module "ec2" {
  source  = "../../modules/ec2"
}