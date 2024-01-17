terraform {
  backend "s3" {
    bucket         = "terraform-sandbox.network"
    key            = "aws/sandbox/Peex/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = var.table_name
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "1106"
    type = "N"
  }
}
