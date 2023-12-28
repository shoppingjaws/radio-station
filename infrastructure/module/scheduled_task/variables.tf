variable "channels" {
  type = list(object({
    title          = string
    id             = string
    area           = string
    station        = string
    exec_time_hour = number
    exec_time_min  = number
    exec_dayweek   = string
    rec_time_hour  = number
    rec_time_min   = number
    rec_dayweek    = string
    image          = string
  }))
}
variable "service" {
  type = string
}
variable "module" {
  type    = string
  default = "scheduled_task"
}
variable "bucket_name" {
  type = string
}
variable "user" {
  type = string
}
variable "password" {
  type = string
}
variable "endpoint" {
  type = string
}