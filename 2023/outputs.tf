##################
# Lambda Function
##################
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.lambda_get.lambda_function_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.lambda_get.lambda_function_name
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

# Route53 record
output "api_endpoint" {
  description = "FQDN of an API endpoint"
  value       = "https://${local.subdomain}.${local.domain_name}"
}
