# Doing serverless on AWS with Terraform for real

This repository contains code for my talks since August 2023.

The architecture created by this code ([source](https://ordina-jworks.github.io/cloud/2019/01/14/Infrastructure-as-code-with-terraform-and-aws-serverless.html)): 

![AWS-Serverless-Architecture](https://raw.githubusercontent.com/antonbabenko/serverless.tf-playground/master/hashitalks2021/AWS-Serverless-Architecture.png)


## Getting started

Run `terraform init` and `terraform apply` to get everything created.

Call API Gateway endpoint using GET or POST methods, for eg:

```
$ http GET $(terraform output -raw apigatewayv2_api_api_endpoint)
```


## How to update and deploy changes?

1. Update source code of the Lambda Functions inside `../src/python-function`
2. Run `terraform apply` to rebuild Lambda Function package (if necessary) and update the dependencies.

PS: There is a way to do complex deployments of AWS Lambda functions using AWS CodeDeploy service, see [tmp-deploy directory for code](https://github.com/antonbabenko/serverless.tf-playground/tree/master/hashitalks2021/tmp-deploy).



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.63 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | terraform-aws-modules/acm/aws | ~> 5.0 |
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | ~> 4.0 |
| <a name="module_dynamodb_table"></a> [dynamodb\_table](#module\_dynamodb\_table) | terraform-aws-modules/dynamodb-table/aws | ~> 4.0 |
| <a name="module_lambda_get"></a> [lambda\_get](#module\_lambda\_get) | terraform-aws-modules/lambda/aws | ~> 7.0 |
| <a name="module_lambda_post"></a> [lambda\_post](#module\_lambda\_post) | terraform-aws-modules/lambda/aws | ~> 7.0 |
| <a name="module_records"></a> [records](#module\_records) | terraform-aws-modules/route53/aws//modules/records | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_endpoint"></a> [api\_endpoint](#output\_api\_endpoint) | FQDN of an API endpoint |
| <a name="output_api_fqdn"></a> [api\_fqdn](#output\_api\_fqdn) | List of Route53 records |
| <a name="output_apigatewayv2_api_api_endpoint"></a> [apigatewayv2\_api\_api\_endpoint](#output\_apigatewayv2\_api\_api\_endpoint) | The URI of the API |
| <a name="output_apigatewayv2_api_arn"></a> [apigatewayv2\_api\_arn](#output\_apigatewayv2\_api\_arn) | The ARN of the API |
| <a name="output_apigatewayv2_api_execution_arn"></a> [apigatewayv2\_api\_execution\_arn](#output\_apigatewayv2\_api\_execution\_arn) | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| <a name="output_apigatewayv2_api_id"></a> [apigatewayv2\_api\_id](#output\_apigatewayv2\_api\_id) | The API identifier |
| <a name="output_apigatewayv2_domain_name_configuration"></a> [apigatewayv2\_domain\_name\_configuration](#output\_apigatewayv2\_domain\_name\_configuration) | The domain name configuration |
| <a name="output_apigatewayv2_domain_name_id"></a> [apigatewayv2\_domain\_name\_id](#output\_apigatewayv2\_domain\_name\_id) | The domain name identifier |
| <a name="output_apigatewayv2_hosted_zone_id"></a> [apigatewayv2\_hosted\_zone\_id](#output\_apigatewayv2\_hosted\_zone\_id) | The Amazon Route 53 Hosted Zone ID of the endpoint |
| <a name="output_apigatewayv2_target_domain_name"></a> [apigatewayv2\_target\_domain\_name](#output\_apigatewayv2\_target\_domain\_name) | The target domain name |
| <a name="output_default_apigatewayv2_stage_execution_arn"></a> [default\_apigatewayv2\_stage\_execution\_arn](#output\_default\_apigatewayv2\_stage\_execution\_arn) | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | ARN of the DynamoDB table |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | ID of the DynamoDB table |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | The ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Latest published version of Lambda Function |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
