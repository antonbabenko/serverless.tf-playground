# Bedrock Agent
module "agent_lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 7.0"

  function_name = "${random_pet.this.id}-bedrock-agent"
  description   = "My awesome Python lambda function as agent"
  handler       = "handler.lambda_handler"
  runtime       = "python3.12"
  timeout       = 60
  architectures = ["arm64"]

  create_lambda_function_url        = false
  cloudwatch_logs_retention_in_days = 7

  source_path = "./src/bedrock_agent/handler.py"

  attach_policy_statements = true
  policy_statements = {
    bedrock = {
      effect = "Allow",
      actions = [
        "bedrock:*"
      ],
      resources = ["*"]
    }
  }
}
