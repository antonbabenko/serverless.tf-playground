module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 2.0"

  name          = "${random_pet.this.id}-http"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"

  domain_name                 = "${local.subdomain}.${local.domain_name}"
  domain_name_certificate_arn = module.acm.acm_certificate_arn

  integrations = {
    "GET /" = {
      lambda_arn             = module.lambda_get.lambda_function_arn
      payload_format_version = "2.0"
    }

    "POST /" = {
      lambda_arn             = module.lambda_post.lambda_function_arn
      payload_format_version = "2.0"
    }

    "$default" = {
      lambda_arn = module.lambda_get.lambda_function_arn
    }
  }
}
