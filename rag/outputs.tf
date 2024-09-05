output "lambda_function_url" {
  description = "The URL of the Lambda Function"
  value       = module.lambda_function.lambda_function_url
}

output "test_command" {
  value = <<EOF
https POST ${module.lambda_function.lambda_function_url} q=="How many resources were deployed?"
EOF
}
