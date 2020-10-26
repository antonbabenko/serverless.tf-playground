provider "aws" {
  region = "eu-west-1"

  # Make it faster by skipping something
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

  # skip_requesting_account_id should be disabled to generate valid ARN in apigatewayv2_api_execution_arn
  skip_requesting_account_id = false
}

terraform {
  backend "inmem" {}
}

data "terraform_remote_state" "local" {
  backend = "local"

  config = {
    path = "../terraform.tfstate"
  }
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_dynamodb_table_item" "this" {
  table_name = data.terraform_remote_state.local.outputs["this_dynamodb_table_id"]
  hash_key   = "id"
  range_key  = "name"
  item       = jsonencode({ "id" : { "S" : uuid() }, "name" : { "S" : random_pet.this.id } })
}
