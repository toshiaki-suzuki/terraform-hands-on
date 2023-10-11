module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  
  enable_dns_hostnames = true
  enable_dns_support = true
  
  azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow-http-80-ownvpc"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow-http-80-myoffice"
      cidr_blocks = "xx.xx.xx.xx/32" // MyIP
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "allow-ssh-22-myoffice"
      cidr_blocks = "xx.xx.xx.xx/32" // MyIP
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = ""
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

# Terraform で秘密鍵と公開鍵のペアを動的に生成する
resource "tls_private_key" "keygen" {
  algorithm = "RSA"
}

# AWS のキーペアを作成する
module "sample_key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "test-key"
  # 公開鍵として、上で定義した tls_private_key リソースの公開鍵 (OpenSSH 形式) を使用
  public_key = tls_private_key.keygen.public_key_openssh
}

# tls_private_key リソースの秘密鍵をPEM形式で提供する
output "private_key_pem" {
  value = tls_private_key.keygen.private_key_pem
  sensitive = true
}

# tls_private_key リソースの公開鍵をOpenSSH形式で提供する
output "public_key_pem" {
  value = tls_private_key.keygen.public_key_openssh
}