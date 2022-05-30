# # Option 1:
# # 1. ~40 resources + data-sources
# # 2. 200 lines of code
# # 
# # Lambda GET
# resource "aws_lambda_function" "lambda_get" {}
# resource "aws_lambda_permission" "lambda_get" {}
# resource "aws_iam_role" "lambda_get" {}
# resource "aws_iam_policy" "lambda_get" {}
# resource "aws_iam_policy_attachment" "lambda_get" {}

# # Lambda POST
# resource "aws_lambda_function" "lambda_post" {}
# resource "aws_lambda_permission" "lambda_post" {}
# resource "aws_iam_role" "lambda_post" {}
# resource "aws_iam_policy" "lambda_post" {}
# resource "aws_iam_policy_attachment" "lambda_post" {}

# # API Gateway
# resource "aws_apigatewayv2_api" "this" {}
# resource "aws_apigatewayv2_domain_name" "this" {}
# resource "aws_apigatewayv2_api_mapping" "this" {}
# resource "aws_apigatewayv2_route" "this" {}
# resource "aws_apigatewayv2_integration" "this" {}

# # DynamoDB
# resource "aws_dynamodb_table" "this" {}



# ---

# # Option 2:
# # 1. ~40 resources + data-sources
# # 2. Add variables and outputs = 1000 lines of code

# # variables.tf
# variable "lambda_get_memory_size" {
#   description = "Memory size for get-record Lambda function"
#   default     = 256
# }

# # Lambda GET
# resource "aws_lambda_function" "lambda_get" {
#   function_name = "get-record"
#   memory_size   = var.lambda_get_memory_size
#   # ...
# }

# resource "aws_lambda_permission" "lambda_get" {}
# resource "aws_iam_role" "lambda_get" {}
# resource "aws_iam_policy" "lambda_get" {}
# resource "aws_iam_policy_attachment" "lambda_get" {}

# # Lambda POST
# resource "aws_lambda_function" "lambda_post" {}
# resource "aws_lambda_permission" "lambda_post" {}
# resource "aws_iam_role" "lambda_post" {}
# resource "aws_iam_policy" "lambda_post" {}
# resource "aws_iam_policy_attachment" "lambda_post" {}

# # API Gateway
# resource "aws_apigatewayv2_api" "this" {}
# resource "aws_apigatewayv2_domain_name" "this" {}
# resource "aws_apigatewayv2_api_mapping" "this" {}
# resource "aws_apigatewayv2_route" "this" {}
# resource "aws_apigatewayv2_integration" "this" {}

# # DynamoDB
# resource "aws_dynamodb_table" "this" {}


# ---

# # Option 3:
# # 1. Move resources into custom Terraform modules
# # 2. Reuse Terraform code for similar resources

# # Lambda GET
# module "lambda_get" {
#   source = "./lambda"

#   function_name = "get-record"
#   memory_size   = var.lambda_get_memory_size
#   # ... values for IAM role, policies, permissions...
# }

# # Lambda POST
# module "lambda_post" {
#   source = "./lambda"

#   function_name = "post-record"
#   memory_size   = var.lambda_post_memory_size
#   # ... values for IAM role, policies, permissions...
# }

# # API Gateway
# module "api_gateway" {}

# # DynamoDB
# module "dynamodb_table" {}

# ---

# # Option 4:
# # 1. Use terraform-aws-modules
# # 2. Much more features than in custom modules
# # 3. Your configuration values = 100 lines of code

# # Lambda GET
# module "lambda_get" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = "get-record"
#   memory_size   = 256
#   # ... values for IAM role, policies, permissions...
# }

# # Lambda POST
# module "lambda_post" {
#   source = "terraform-aws-modules/lambda/aws"

#   function_name = "post-record"
#   memory_size   = 512
#   # ... values for IAM role, policies, permissions...
# }

# # API Gateway
# module "api_gateway" {
#   source = "terraform-aws-modules/apigateway-v2/aws"
# }

# # DynamoDB
# module "dynamodb_table" {
#   source = "terraform-aws-modules/dynamodb-table/aws"
# }
