data "aws_cloudfront_origin_request_policy" "cors_s3_origin" {
  name = "Managed-CORS-S3Origin"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

resource "aws_cloudfront_distribution" "main" {
  enabled = true

  origin {
    origin_id                = aws_s3_bucket.main.id
    domain_name              = aws_s3_bucket.main.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.main.id
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  default_cache_behavior {
    target_origin_id         = aws_s3_bucket.main.id
    viewer_protocol_policy   = "redirect-to-https"
    cached_methods           = ["GET", "HEAD"]
    allowed_methods          = ["GET", "HEAD"]
    origin_request_policy_id = data.aws_cloudfront_origin_request_policy.cors_s3_origin.id
    cache_policy_id          = data.aws_cloudfront_cache_policy.caching_disabled.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.basicauth.arn
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "main" {
  name                              = var.name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_function" "basicauth" {
  name    = "${var.name}-basicauth"
  runtime = "cloudfront-js-1.0"
  publish = true
  code = templatefile(
    "${path.module}/index.js",
    {
      authString = base64encode("${var.basicauth_username}:${var.basicauth_password}")
    }
  )
}