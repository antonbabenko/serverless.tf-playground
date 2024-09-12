module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 5.0"

  name          = "${random_pet.this.id}-http"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  domain_name = local.domain_name
  subdomains  = [local.subdomain]

  routes = {
    "GET /" = {
      integration = {
        uri                    = module.lambda_get.lambda_function_arn
        payload_format_version = "2.0"
      }
    }
    "POST /" = {
      integration = {
        uri                    = module.lambda_post.lambda_function_arn
        payload_format_version = "2.0"
      }
    }
    "$default" = {
      integration = {
        uri                    = module.lambda_get.lambda_function_arn
        payload_format_version = "2.0"
      }
    }
  }
}
