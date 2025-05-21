module "lambda_get" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 7.0"

  function_name = "${random_pet.this.id}-lambda-get"
  description   = "My awesome Python lambda function"
  handler       = "get.lambda_handler"
  runtime       = "python3.13"
  publish       = true

  source_path = "../src/python-function/get.py"

  attach_tracing_policy    = true
  attach_policy_statements = true

  environment_variables = {
    DYNAMODB_TABLE_NAME = module.dynamodb_table.dynamodb_table_id
  }

  policy_statements = {
    dynamodb_read = {
      effect    = "Allow",
      actions   = ["dynamodb:Scan"],
      resources = [module.dynamodb_table.dynamodb_table_arn]
    }
  }

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.api_execution_arn}/*/GET/*"
    }
  }
}
