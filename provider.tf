terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
    backend "s3" {
    bucket = "terraform-docker-instance"
    key    = "terraform-code-for-sample-docker-instance"
    region = "us-east-1"
    use_lockfile = true
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}