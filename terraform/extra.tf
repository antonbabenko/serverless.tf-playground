# Put all extra resources which don't belong anywhere

resource "aws_codedeploy_app" "this" {
  name             = random_pet.this.id
  compute_platform = "Lambda"
}
