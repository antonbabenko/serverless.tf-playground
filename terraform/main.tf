provider "aws" {
  region = "eu-west-1"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  # skip_requesting_account_id should be disabled to generate valid ARN in apigatewayv2_api_execution_arn
  skip_requesting_account_id = false
}

resource "random_pet" "this" {
  length = 2
}

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 0.0"
  //  source = "../../terraform-aws-modules/terraform-aws-apigateway-v2"

  name          = "${random_pet.this.id}-http"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  create_api_domain_name = false

  default_stage_access_log_destination_arn = "arn:aws:logs:eu-west-1:835367859851:log-group:debug-apigateway"
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  integrations = {
    "ANY /" = {
      lambda_arn             = module.lambda.this_lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "$default" = {
      lambda_arn = module.lambda.this_lambda_function_arn
    }

  }
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 1.0"
  //  source = "../../terraform-aws-modules/terraform-aws-lambda"

  function_name = "${random_pet.this.id}-lambda1"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"
  publish       = true

  source_path = "../src/python-function"

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service = "apigateway"
      arn     = module.api_gateway.this_apigatewayv2_api_execution_arn
    }
  }
}

module "alias" {
  source  = "terraform-aws-modules/lambda/aws//modules/alias"
  version = "~> 1.0"
  //  source = "../../terraform-aws-modules/terraform-aws-lambda/modules/alias"

  name = "prod"

  function_name = module.lambda.this_lambda_function_name

  # Set function_version when creating alias to be able to deploy using it,
  # because AWS CodeDeploy doesn't understand $LATEST as CurrentVersion.
  function_version = module.lambda.this_lambda_function_version
}

module "deploy" {
  source  = "terraform-aws-modules/lambda/aws//modules/deploy"
  version = "~> 1.0"
  //  source = "../../terraform-aws-modules/terraform-aws-lambda/modules/deploy"

  alias_name    = module.alias.this_lambda_alias_name
  function_name = module.lambda.this_lambda_function_name

  target_version = module.lambda.this_lambda_function_version
  description    = "This is my awesome deploy!"

  use_existing_app = true
  app_name         = aws_codedeploy_app.this.name

  create_deployment_group = true
  deployment_group_name   = "prod"

  create_deployment          = true
  wait_deployment_completion = true
  //  force_deploy               = true

}
