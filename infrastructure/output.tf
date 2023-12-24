output "endpoint_url" {
  value = module.basic_auth_s3.endpoint
}
output "iam" {
  value = aws_iam_policy.policy.arn
}