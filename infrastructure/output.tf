output "endpoint_url" {
  value     = [for channel in var.channels : { title : channel.title, link : nonsensitive("https://${module.basic_auth_s3.user}:${module.basic_auth_s3.password}@${module.basic_auth_s3.endpoint}/${channel.id}/index.rss") }]
  sensitive = false
}
