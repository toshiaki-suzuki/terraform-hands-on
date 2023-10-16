data "aws_ssm_parameter" "amzn2_ami_latest" {
  # Kernel 5.10
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-kernel-5.10-hvm-x86_64-gp2"
  #  Kernel 4.14
  #  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  
  name = "test-ec2"

  ami                    = data.aws_ssm_parameter.amzn2_ami_latest.value
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.security-group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl enable httpd.service
    systemctl start httpd.service
EOF
}