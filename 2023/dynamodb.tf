module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0"

  name      = random_pet.this.id
  hash_key  = "id"
  range_key = "name"

  attributes = [
    {
      name = "id"
      type = "S"
    },
    {
      name = "name"
      type = "S"
    },
  ]
}

# resource "aws_dynamodb_table_item" "this" {
#   table_name = module.dynamodb_table.dynamodb_table_id
#   hash_key   = "id"
#   range_key  = "name"

#   item = jsonencode({
#     "id" = {"S": "1"}
#     "name" = {"S": "test"}
#   })
# }
