module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow-http-80-ownvpc"
      cidr_blocks = var.vpc_cidr_blocks
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "allow-http-80-myoffice"
      cidr_blocks = var.myIp // MyIP
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "allow-ssh-22-myoffice"
      cidr_blocks = var.myIp // MyIP
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