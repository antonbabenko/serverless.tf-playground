provider "aws" {
  region = "eu-west-1"
}

# locals {
#   domain_name = "terraform-aws-modules.modules.tf" # trimsuffix(data.aws_route53_zone.this.name, ".")
#   subdomain   = "serverless-playground"
# }

resource "random_pet" "this" {
  length = 2
}
