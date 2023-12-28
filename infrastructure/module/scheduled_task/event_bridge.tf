resource "aws_scheduler_schedule_group" "event_bridge" {
  name = "radio-station"
}

resource "aws_scheduler_schedule" "event_bridge" {
  for_each   = { for idx, cfg in var.channels : idx => cfg }
  name       = each.value.id
  group_name = aws_scheduler_schedule_group.event_bridge.name
  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 15
  }
  schedule_expression_timezone = "Asia/Tokyo"
  schedule_expression          = join("", ["cron(", join(" ", [each.value.exec_time_min, each.value.exec_time_hour, "? *", each.value.exec_dayweek, "*"]), ")"])

  target {
    retry_policy {
      maximum_event_age_in_seconds = 120
      maximum_retry_attempts       = 2
    }
    arn      = aws_lambda_function.lambda.arn
    role_arn = aws_iam_role.event_bridge.arn

    input = jsonencode({
      title          = each.value.title
      id             = each.value.id
      area           = each.value.area
      station        = each.value.station
      exec_time_hour = each.value.exec_time_hour
      exec_time_min  = each.value.exec_time_min
      exec_dayweek   = each.value.exec_dayweek
      rec_time_hour  = each.value.rec_time_hour
      rec_time_min   = each.value.rec_time_min
      rec_dayweek    = each.value.rec_dayweek
    })
  }
}

resource "aws_iam_role" "event_bridge" {
  name        = "${var.service}_${var.module}_event_bridge"
  description = "eventbridge execution role"
  inline_policy {
    name = "${var.service}_${var.module}_event_bridge"
    policy = jsonencode({
      Statement = [
        {
          Action   = ["lambda:InvokeFunction"]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
  assume_role_policy = data.aws_iam_policy_document.name.json
}

data "aws_iam_policy_document" "name" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}