output "endpoint" {
  value = aws_cloudfront_distribution.main.domain_name
}
output "user" {
  value = var.basicauth_username
}
output "password" {
  value     = random_password.password.result
  sensitive = false
}
output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}