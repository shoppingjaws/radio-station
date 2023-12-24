output "endpoint" {
  value = join("", ["https://", aws_cloudfront_distribution.main.domain_name])
}
