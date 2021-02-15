## serverless.tf playground to show it in action

This repository is a playground for [serverless.tf](https://github.com/antonbabenko/serverless.tf) approach, which aims to simplify all operations when working with the serverless in Terraform.


## Flow

1. Source code for Lambda Functions is in `src` folder.
1. All infrastructure configuration and deployment configurations is in `terraform` folder.
1. When code changes, and developer wants to "deploy it to prod", run `cd terraform && terraform init && terraform apply`. This will build deployment package, update resources, and deploy all to _prod_ using AWS CodeDeploy.

## Useful commands

```
$ http https://vdlsaentfnbvtaes7aduvzrwdm.appsync-api.eu-west-1.amazonaws.com/graphql x-api-key:da2-1enspdfpdvfvlk4efjqto4oks4 query='{ listPets { id name } }'
```

## To-do

1. Use Terragrunt for orchestration (deploy one by one or all together with respective dependencies)
1. Group resources (eg, by layer (lambdas, for eg), environment, or region)


## Authors

This repository managed by [Anton Babenko](https://github.com/antonbabenko). Check out [serverless.tf](https://serverless.tf) to learn more about doing serverless with Terraform.

Please reach out to [Betajob](https://www.betajob.com/) if you are looking for commercial support for your Terraform, AWS, or serverless project.


## License

Apache 2 Licensed. See LICENSE for full details.
