module "step_function" {
  source  = "terraform-aws-modules/step-functions/aws"
  version = "~> 2.0"

  name = random_pet.this.id

  definition = jsonencode(yamldecode(templatefile("step_function.asl.yaml", {
    lambda1_arn = module.lambda_get.lambda_function_arn
  })))

  trusted_entities = ["apigateway.amazonaws.com"]

  service_integrations = {
    lambda = {
      lambda = [
        module.lambda_get.lambda_function_arn,
      ]
    }

    stepfunction = {
      stepfunction = ["*"]
    }
  }
}