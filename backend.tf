terraform {
  backend "s3" {
    bucket    = "516610242115-state-file-bucket"
    key       = "iac-terraform-demo1.tfstate"
    region    = "us-east-1"
    dynamodb_table = "iac-terraform-demo1-dynamodb-table"
    profile   = "aws-ubuntu-local"
  }
}