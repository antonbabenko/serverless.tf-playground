locals {
  region = "us-east-1"
}

provider "aws" {
  region = local.region
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 7.0"

  function_name = "${random_pet.this.id}-bedrock-rag"
  description   = "My awesome Python lambda function"
  handler       = "kb_rag.lambda_handler"
  runtime       = "python3.12"
  timeout       = 60
  architectures = ["arm64"]

  create_lambda_function_url        = true
  cloudwatch_logs_retention_in_days = 7

  source_path = "./src/kb_rag.py"

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
    KB_ID  = aws_bedrockagent_knowledge_base.this.id
    REGION = local.region
  }
}

# Bedrock Knowledgebase
resource "aws_bedrockagent_knowledge_base" "this" {
  name     = "knowledge-base-quick-start-sx80g"
  role_arn = "arn:aws:iam::835367859851:role/service-role/AmazonBedrockExecutionRoleForKnowledgeBase_sx80g"

  knowledge_base_configuration {
    type = "VECTOR"
    vector_knowledge_base_configuration {
      embedding_model_arn = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v1"
    }
  }

  storage_configuration {
    type = "OPENSEARCH_SERVERLESS"
    opensearch_serverless_configuration {
      collection_arn    = "arn:aws:aoss:us-east-1:835367859851:collection/sv4pmipz38orb8xmj08j"
      vector_index_name = "bedrock-knowledge-base-default-index"
      field_mapping {
        metadata_field = "AMAZON_BEDROCK_METADATA"
        text_field     = "AMAZON_BEDROCK_TEXT_CHUNK"
        vector_field   = "bedrock-knowledge-base-default-vector"
      }
    }
  }
}

# todo: add KB data source with S3 bucket

resource "random_pet" "this" {
  length = 2
}
