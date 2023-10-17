module "vpc" {
  source  = "../../modules/vpc"
}

module "sg" {
  source  = "../../modules/sg"
  vpc_id = module.vpc.vpc_id
  vpc_cidr_blocks = module.vpc.vpc_cidr_block
}

module "keypair" {
  source  = "../../modules/keypair"
}

module "ec2" {
  source  = "../../modules/ec2"
  subnet_id = module.vpc.subnet_id
  vpc_security_group_ids = module.sg.vpc_security_group_ids
  key_name = module.keypair.key_name
}