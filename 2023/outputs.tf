########################
# Lambda Function - GET
########################
output "lambda_get_function_name" {
  description = "The name of the Lambda Function - GET"
  value       = module.lambda_get.lambda_function_name
}

########################
# Lambda Function - POST
########################
output "lambda_post_function_name" {
  description = "The name of the Lambda Function - POST"
  value       = module.lambda_post.lambda_function_name
}

#################
# DynamoDB Table
#################
output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.dynamodb_table.dynamodb_table_arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = module.dynamodb_table.dynamodb_table_id
}

########################
# API Gateway
########################
output "api_endpoint" {
  description = "FQDN of an API endpoint"
  value       = module.api_gateway.api_endpoint
}
