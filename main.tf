terraform {
  cloud {
    organization = "terraform-beginner-bootcamp3"
    workspaces {
      name = "terra-house-3"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}




#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  upper            = false
  lower            = true
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  #AWS S3 bucket naming rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result

  #tags = {
    #UserUuid = var.user_uuid
  #}

}

