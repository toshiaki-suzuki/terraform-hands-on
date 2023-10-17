# Terraform で秘密鍵と公開鍵のペアを動的に生成する
resource "tls_private_key" "keygen" {
  algorithm = "RSA"
}

# AWS のキーペアを作成する
module "key_pair" {
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