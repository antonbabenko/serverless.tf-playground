module "lambda_get" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 3.0"

  function_name = "${random_pet.this.id}-lambda-get"
  description   = "My awesome Python lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  publish       = true

  # Real AWS infra
  #  create_package = false
  #  s3_existing_package = {
  #    bucket = "fixtures"
  #    key    = "python3.8-zip/existing_package.zip"
  #  }

  # LocalStack AWS infra
  #  awslocal s3 mb s3://fixtures
  #  awslocal s3 cp /Users/Bob/Sites/terraform-aws-modules/terraform-aws-lambda/examples/fixtures/python3.8-zip/existing_package.zip s3://fixtures/python3.8-zip/existing_package.zip
  create_package = false
  s3_existing_package = {
    bucket = "fixtures"
    key    = "python3.8-zip/existing_package.zip"
  }

  # LocalStack hot swap
  #  create_package = true
  #  source_path = "/Users/Bob/Sites/terraform-aws-modules/terraform-aws-lambda/examples/fixtures/python3.8-app1"

  #    create_package = false
  #    s3_existing_package = {
  #      bucket = "__local__"
  #      key    = "/Users/Bob/Sites/terraform-aws-modules/terraform-aws-lambda/examples/fixtures/python3.8-app1"
  #    }
  #  s3_bucket = "__local__"
  #  s3_prefix = "/Users/Bob/Sites/terraform-aws-modules/terraform-aws-lambda/examples/fixtures/python3.8-app1"

  #  ephemeral_storage_size = null

  attach_tracing_policy    = true
  attach_policy_statements = true

  policy_statements = {
    dynamodb_read = {
      effect    = "Allow",
      actions   = ["dynamodb:GetItem"],
      resources = [module.dynamodb_table.dynamodb_table_arn]
    }
  }

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*/*"
    }
  }
}
