# Code for my talk "Why and how to use Terraform AWS modules?"

This repository contains code for my talk at Open@Amazon 2021:

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

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| acm | terraform-aws-modules/acm/aws | ~> 2.0 |
| api_gateway | terraform-aws-modules/apigateway-v2/aws | ~> 0.0 |
| apigateway_put_events_to_eventbridge_policy | terraform-aws-modules/iam/aws//modules/iam-policy | ~> 3 |
| apigateway_put_events_to_eventbridge_role | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 3 |
| dynamodb_table | terraform-aws-modules/dynamodb-table/aws | ~> 0 |
| lambda_get | terraform-aws-modules/lambda/aws | ~> 1.0 |
| lambda_post | terraform-aws-modules/lambda/aws | ~> 1.0 |
| step_function | terraform-aws-modules/step-functions/aws | ~> 1.0 |

## Resources

| Name |
|------|
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) |
| [random_pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| api\_endpoint | FQDN of an API endpoint |
| api\_fqdn | List of Route53 records |
| apigateway\_put\_events\_to\_eventbridge\_role\_arn | n/a |
| default\_apigatewayv2\_stage\_execution\_arn | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| this\_apigatewayv2\_api\_api\_endpoint | The URI of the API |
| this\_apigatewayv2\_api\_arn | The ARN of the API |
| this\_apigatewayv2\_api\_execution\_arn | The ARN prefix to be used in an aws\_lambda\_permission's source\_arn attribute or in an aws\_iam\_policy to authorize access to the @connections API. |
| this\_apigatewayv2\_api\_id | The API identifier |
| this\_apigatewayv2\_domain\_name\_configuration | The domain name configuration |
| this\_apigatewayv2\_domain\_name\_id | The domain name identifier |
| this\_apigatewayv2\_hosted\_zone\_id | The Amazon Route 53 Hosted Zone ID of the endpoint |
| this\_apigatewayv2\_target\_domain\_name | The target domain name |
| this\_dynamodb\_table\_arn | ARN of the DynamoDB table |
| this\_dynamodb\_table\_id | ID of the DynamoDB table |
| this\_lambda\_function\_arn | The ARN of the Lambda Function |
| this\_lambda\_function\_invoke\_arn | The Invoke ARN of the Lambda Function |
| this\_lambda\_function\_name | The name of the Lambda Function |
| this\_lambda\_function\_qualified\_arn | The ARN identifying your Lambda Function Version |
| this\_lambda\_function\_version | Latest published version of Lambda Function |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
