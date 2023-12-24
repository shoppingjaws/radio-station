terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  cloud {
    organization = "ShoppingJaws"

    workspaces {
      name = "radio-station"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      service = "radio-station"
    }
  }
  region = "us-east-1"
}


module "basic_auth_s3" {
  source             = "./module/basic_auth_s3"
  bucket_name        = "radio-station-shoppingjaws"
  name               = "radio-station"
  basicauth_password = "6t3hahhL7RDLZRVgXKGp"
  basicauth_username = "ShoppingJaws"
}
resource "aws_iam_policy" "policy" {
  name        = "s3_radio_station_upload_policy"
  description = "s3 upload policy used at GHA"
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Sid"    = "VisualEditor0",
        "Effect" = "Allow",
        "Action" = [
          "s3:PutObject",
          "s3:ListBucket"
        ],
        "Resource" = [
          "arn:aws:s3:::radio-station-shoppingjaws"
        ]
      }
    ]
  })
}