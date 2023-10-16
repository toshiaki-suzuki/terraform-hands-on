module "vpc" {
  source  = "./modules"
}

module "sg" {
  source  = "./modules"
}

module "keypair" {
  source  = "./modules"
}

module "ec2" {
  source  = "./modules"
}