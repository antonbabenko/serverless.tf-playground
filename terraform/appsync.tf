module "appsync" {
  source  = "terraform-aws-modules/appsync/aws"
  version = "~> 0"

  name = random_pet.this.id

  schema = file("schema.graphql")

  api_keys = {
    default = null
  }

  datasources = {
    #    lambda1 = {
    #      type = "AWS_LAMBDA"
    #
    # Note: dynamic references (module.aws_lambda_function1.this_lambda_function_arn) do not work unless you create this resource in advance
    #      function_arn = "arn:aws:lambda:eu-west-1:835367859851:function:index_1"
    #    }

    dynamodb1 = {
      type = "AMAZON_DYNAMODB"

      # Note: dynamic references (module.dynamodb_table1.this_dynamodb_table_id) do not work unless you create this resource in advance
      table_name = random_pet.this.id
      region     = "eu-west-1"
    }
  }

  resolvers = {
    #    "Mutation.putPet" = {
    #      data_source   = "lambda1"
    #      direct_lambda = true
    #    }

    "Query.listPets" = {
      data_source      = "dynamodb1"
      request_template = <<EOF
{
    "version" : "2017-02-28",
    "operation" : "Scan",
}
EOF

      response_template = <<EOF
$util.toJson($ctx.result.items)
EOF
    }

  }

}
