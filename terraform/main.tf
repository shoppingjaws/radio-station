
terraform {
  backend "s3" {
    bucket = "shoppingjaws-radio-station-state"
    region = "ap-northeast-1"
    versioning {
      enabled = true
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_s3_bucket" "radio-station" {
  bucket = "radio-station-shoppingjaws"
  acl    = "private"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
EOF
}


