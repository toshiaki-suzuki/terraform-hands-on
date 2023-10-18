# tls_private_key リソースの秘密鍵をPEM形式で提供する
output "private_key_pem" {
  value = tls_private_key.keygen.private_key_pem
  sensitive = true
}

# tls_private_key リソースの公開鍵をOpenSSH形式で提供する
output "public_key_pem" {
  value = tls_private_key.keygen.public_key_openssh
}

output "key_name" {
  value = module.key_pair.key_pair_name
}