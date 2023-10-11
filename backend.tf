# tfstate をローカル管理する場合
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

# tfstate をS3管理する場合
# terraform {
#   backend "s3" {
#     bucket  = "bucket-name"
#     region  = "us-east-1"
#     key     = "dir/terraform.tfstate"
#     encrypt = false
# S3のAWSアカウントがデプロイ先と異なる場合に指定
#    access_key = ""
#    secret_key = ""
#   }
# }