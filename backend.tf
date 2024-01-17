terraform {
  backend "s3" {
    bucket         = "terraform-sandbox.network"
    key            = "aws/sandbox/Peex/"
    region         = "us-east-2"
    dynamodb_table = "terraform-sandbox-us-west-2-lock-dynamo"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-west-2"
}