module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 0.0"

  name          = "${random_pet.this.id}-http"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  domain_name                 = "${local.subdomain}.${local.domain_name}"
  domain_name_certificate_arn = module.acm.this_acm_certificate_arn

  integrations = {
    "GET /" = {
      lambda_arn             = module.lambda_get.this_lambda_function_arn
      payload_format_version = "2.0"
    }

    "POST /" = {
      lambda_arn             = module.lambda_post.this_lambda_function_arn
      payload_format_version = "2.0"
    }

    "POST /start-step-function" = {
      integration_type    = "AWS_PROXY"
      integration_subtype = "StepFunctions-StartExecution"

      # @todo: Using the same IAM role as Step Function is not the best solution, but I do it anyway :)
      credentials_arn = module.step_function.this_role_arn

      # Note: jsonencode is used to pass argument as a string
      request_parameters = jsonencode({
        StateMachineArn = module.step_function.this_state_machine_arn
      })

      payload_format_version = "1.0"
      timeout_milliseconds   = 12000
    }

    "POST /webhook" = {
      integration_type    = "AWS_PROXY"
      integration_subtype = "EventBridge-PutEvents"
      credentials_arn     = module.apigateway_put_events_to_eventbridge_role.this_iam_role_arn

      request_parameters = jsonencode({
        DetailType = "Webhook from external service",
        Detail     = "$request.body",
        Source     = "webhook"
      })

      payload_format_version = "1.0"
    }

    "$default" = {
      lambda_arn = module.lambda_get.this_lambda_function_arn
    }

  }

}
