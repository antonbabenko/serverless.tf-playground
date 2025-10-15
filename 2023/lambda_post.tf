module "lambda_post" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 8.0"

  function_name = "${random_pet.this.id}-lambda-post"
  description   = "My awesome Python lambda function"
  handler       = "post.lambda_handler"
  runtime       = "python3.13"
  publish       = true

  source_path = [
    {
      path             = "${path.module}/../src/python-function"
      pip_requirements = true
      patterns = [
        "!.*\\.dist-info/.*",
        "!\\.venv/.*",
      ]
    }
  ]

  attach_tracing_policy    = true
  attach_policy_statements = true

  environment_variables = {
    DYNAMODB_TABLE_NAME = module.dynamodb_table.dynamodb_table_id
  }

  policy_statements = {
    dynamodb_write = {
      effect    = "Allow",
      actions   = ["dynamodb:PutItem"],
      resources = [module.dynamodb_table.dynamodb_table_arn]
    }
  }

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.api_execution_arn}/*/POST/*"
    }
  }
}
