resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-sandbox.network"
    key            = "aws/sandbox/Peex/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-sandbox-us-west-2-lock-dynamo"
    encrypt        = true
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.19.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

