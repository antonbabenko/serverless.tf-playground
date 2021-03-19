resource "aws_cloudwatch_event_rule" "this" {
  name        = "..."
  description = "Forward to ..."

  event_pattern = <<EOF
{
  "source": [
    "webhook"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "this_that" {
  rule       = aws_cloudwatch_event_rule.this.name
  arn        = "arn:aws:states:eu-west-1:152235879155:stateMachine:abc"
  role_arn   = aws_iam_role.stepfunction.arn
  input_path = "$.detail"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "stepfunction" {
  statement {
    sid = "StepFunctionStart"

    effect = "Allow"

    actions = [
      "states:StartExecution"
    ]

    resources = ["arn:aws:states:eu-west-1:152235879155:stateMachine:abc"]
  }
}

resource "aws_iam_role" "stepfunction" {
  name_prefix        = "stepfunction-"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "stepfunction" {
  role   = aws_iam_role.stepfunction.name
  policy = data.aws_iam_policy_document.stepfunction.json
}
