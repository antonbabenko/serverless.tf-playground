provider "aws" {
  region = "us-east-1"
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 7.0"

  function_name = "${random_pet.this.id}-bedrock-rag"
  description   = "My awesome Python lambda function"
  handler       = "kb_rag.lambda_handler"
  runtime       = "python3.12"
  timeout       = 30
  architectures = ["arm64"]

  create_lambda_function_url        = true
  cloudwatch_logs_retention_in_days = 7

  source_path = "./src/kb_rag.py"


  attach_tracing_policy    = true
  attach_policy_statements = true

  policy_statements = {
    bedrock = {
      effect = "Allow",
      actions = [
        "bedrock:PutUseCaseForModelAccess",
        "bedrock:GetUseCaseForModelAccess",
        "bedrock:DeleteFoundationModelAgreement",
        "bedrock:CreateAgent",
        "bedrock:GetFoundationModelAvailability",
        "bedrock:GetModelInvocationLoggingConfiguration",
        "bedrock:ListFoundationModelAgreementOffers",
        "bedrock:AssociateThirdPartyKnowledgeBase",
        "bedrock:DeleteModelInvocationLoggingConfiguration",
        "bedrock:ListKnowledgeBases",
        "bedrock:PutFoundationModelEntitlement",
        "bedrock:ListModelCustomizationJobs",
        "bedrock:ListAgents",
        "bedrock:ListProvisionedModelThroughputs",
        "bedrock:ListCustomModels",
        "bedrock:CreateKnowledgeBase",
        "bedrock:PutModelInvocationLoggingConfiguration",
        "bedrock:ListFoundationModels",
        "bedrock:CreateFoundationModelAgreement",
        "bedrock:InvokeModel",
        "bedrock:Retrieve",
        "bedrock:RetrieveAndGenerate"
      ],
      resources = ["*"]
    }
  }

  environment_variables = {
    KB_ID  = "ICF8JBMOU1"
    REGION = "us-east-1"
  }
}

resource "random_pet" "this" {
  length = 2
}
