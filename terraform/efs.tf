module "lambda_function_with_efs" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 1.0"

  function_name = "${random_pet.this.id}-lambda-in-vpc-with-efs"
  description   = "My awesome lambda function in VPC with EFS"
  handler       = "index.lambda_handler"
  runtime       = "python3.8"

  source_path = "../src/python-function"

  vpc_subnet_ids         = module.vpc.intra_subnets
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  attach_network_policy  = true

  attach_policy_statements = true

  policy_statements = {
    allow_efs_mount = {
      effect = "Allow"
      actions = [
        "elasticfilesystem:ClientMount",
        "elasticfilesystem:ClientWrite",
      ]
      resources = [aws_efs_file_system.shared.arn]
      condition = [
        {
          test     = "StringEquals"
          variable = "elasticfilesystem:AccessPointArn"
          values   = [aws_efs_access_point.lambda.arn]
        }
      ]
    }
  }

  ######################
  # Elastic File System
  ######################

  file_system_arn              = aws_efs_access_point.lambda.arn
  file_system_local_mount_path = "/mnt/shared-storage"

  # Explicitly declare dependency on EFS mount target.
  # When creating or updating Lambda functions, mount target must be in 'available' lifecycle state.
  # Note: depends_on on modules became available in Terraform 0.13
  depends_on = [aws_efs_mount_target.alpha]
}

######
# VPC
######

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = random_pet.this.id
  cidr = "10.10.0.0/16"

  azs           = ["eu-west-1a"]
  intra_subnets = ["10.10.101.0/24"]
}

######
# EFS
######

resource "aws_efs_file_system" "shared" {}

resource "aws_efs_mount_target" "alpha" {
  file_system_id  = aws_efs_file_system.shared.id
  subnet_id       = module.vpc.intra_subnets[0]
  security_groups = [module.vpc.default_security_group_id]
}

resource "aws_efs_access_point" "lambda" {
  file_system_id = aws_efs_file_system.shared.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/lambda"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0777"
    }
  }
}
