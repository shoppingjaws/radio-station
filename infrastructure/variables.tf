variable "app_name" {
  type      = string
  sensitive = false
  default   = "radio-station-shoppingjaws"
}

variable "tfstate-bucket-name" {
  type    = string
  default = "radio-station-tfstate"
}

