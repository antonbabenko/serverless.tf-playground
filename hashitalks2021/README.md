# Doing serverless on AWS with Terraform for real

This repository contains code for my talk at HashiTalks 2021.

The architecture created by this code ([source](https://ordina-jworks.github.io/cloud/2019/01/14/Infrastructure-as-code-with-terraform-and-aws-serverless.html)): 

![AWS-Serverless-Architecture](https://raw.githubusercontent.com/antonbabenko/serverless.tf-playground/master/hashitalks2021/AWS-Serverless-Architecture.png)


## Getting started

Run `terraform init` and `terraform apply` to get everything created.

Call API Gateway endpoint using GET or POST methods, for eg:

```
$ http GET $(terraform output -raw this_apigatewayv2_api_api_endpoint)
```

 
## How to update and deploy changes?

1. Update source code of the Lambda Functions inside `../src/python-function`
2. Run `terraform apply` to rebuild Lambda Function package (if necessary) and update the dependencies.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| random | n/a |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| default\_apigatewayv2\_stage\_execution\_arn | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| this\_apigatewayv2\_api\_api\_endpoint | The URI of the API |
| this\_apigatewayv2\_api\_arn | The ARN of the API |
| this\_apigatewayv2\_api\_execution\_arn | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| this\_apigatewayv2\_api\_id | The API identifier |
| this\_dynamodb\_table\_arn | ARN of the DynamoDB table |
| this\_dynamodb\_table\_id | ID of the DynamoDB table |
| this\_lambda\_function\_arn | The ARN of the Lambda Function |
| this\_lambda\_function\_invoke\_arn | The Invoke ARN of the Lambda Function |
| this\_lambda\_function\_name | The name of the Lambda Function |
| this\_lambda\_function\_qualified\_arn | The ARN identifying your Lambda Function Version |
| this\_lambda\_function\_version | Latest published version of Lambda Function |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
