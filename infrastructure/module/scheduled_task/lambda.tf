resource "aws_lambda_function" "lambda" {
  function_name = "${var.service}_${var.module}"
  package_type  = "Image"
  architectures = ["arm64"]
  memory_size   = 1024
  role          = aws_iam_role.execution.arn
  image_uri     = "${aws_ecr_repository.ecr.repository_url}:latest"
  timeout       = 720
  environment {
    variables = {
      BUCKET_NAME  = var.bucket_name
      RSS_ENDPOINT = "https://${var.user}:${var.password}@${var.endpoint}"
    }
  }
}

resource "aws_iam_role" "execution" {
  name = "${var.service}_${var.module}_execution"
  inline_policy {
    name = "${var.service}_${var.module}_execution"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "s3:Get*",
            "s3:List*",
            "s3:Describe*",
            "s3:Put*",
          ]
          Resource = ["arn:aws:s3:::${var.bucket_name}/*", "arn:aws:s3:::${var.bucket_name}"]
          }, {
          Effect = "Allow"
          Action = ["logs:CreateLogGroup",
            "logs:CreateLogStream",
          "logs:PutLogEvents"]
          Resource = "${aws_cloudwatch_log_group.log.arn}:*"
          }, {
            Effect = "Allow"
            Action = ["ssm:GetParameter"]
            Condition = {
              StringEquals = {
                "ssm:ResourceTag/service": [
                  "radio-station"
                ]
              }
            }
            Resource = "arn:aws:ssm:*:${data.aws_caller_identity.current.account_id}:parameter/*"
          }
      ]
    })
  }
  assume_role_policy = data.aws_iam_policy_document.execution.json
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "execution" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    resources = []
    actions   = ["sts:AssumeRole"]
  }
}

resource "aws_cloudwatch_log_group" "log" {
  name              = "/aws/lambda/${var.service}_${var.module}"
  retention_in_days = 30
}

data "aws_ssm_parameter" "email" {
  name = "/radio-station/email"
}

data "aws_ssm_parameter" "password" {
  name = "/radio-station/password"
}
