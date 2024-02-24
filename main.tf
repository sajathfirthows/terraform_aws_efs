provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "dev-saja"
    key    = "stg-saja-new/terraform.tfstate"
    region = "us-east-1"
  }
}
