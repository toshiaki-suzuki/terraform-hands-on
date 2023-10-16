# tfstate をローカル管理する場合
# terraform {
#   backend "local" {
#     path = "./terraform.tfstate"
#   }
# }

# tfstate をS3管理する場合
terraform {
  backend "s3" {
    bucket  = "tfstate-AccountID" # 格納先のバケット名に変更
    region  = "ap-northeast-1"
    key     = "hands_on1/terraform.tfstate"
    encrypt = false
# S3のAWSアカウントがデプロイ先と異なる場合に指定
#   access_key = ""
#   secret_key = ""
  }
}