terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
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
  region = "ap-northeast-1"
}


module "basic_auth_s3" {
  source             = "./module/basic_auth_s3"
  bucket_name        = "radio-station-shoppingjaws"
  name               = "radio-station"
  basicauth_username = "ShoppingJaws"
}

module "radio_uploader" {
  source      = "./module/scheduled_task"
  channels    = var.channels
  service     = var.service
  bucket_name = module.basic_auth_s3.bucket_name
  endpoint    = module.basic_auth_s3.endpoint
  user        = module.basic_auth_s3.user
  password    = module.basic_auth_s3.password
}

resource "aws_resourcegroups_group" "radio_station" {
  name = "radio_station"
  resource_query {
    query = jsonencode(
      {
        ResourceTypeFilters = ["AWS::AllSupported"],
        TagFilters = [
          {
            Key    = "service"
            Values = [var.service]
          }
        ]
    })
  }
}

resource "aws_applicationinsights_application" "example" {
  resource_group_name = aws_resourcegroups_group.radio_station.name
}