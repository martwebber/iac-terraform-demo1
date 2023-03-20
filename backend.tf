terraform {
  backend "s3" {
    bucket    = "516610242115-state-file-bucket"
    key       = "iac-terraform-demo1.tfstate"
    region    = "us-east-1"
    profile   = "aws-ubuntu-local"
  }
}