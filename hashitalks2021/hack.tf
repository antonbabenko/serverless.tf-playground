resource "null_resource" "tfvars" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "ls -al /opt /opt/data /opt/workdir /opt/plugins /opt/plugins/shared /opt/data /bin /opt/workdir/.config /opt/workdir/.config/git && cat /opt/workdir/scalr_override.tf.json /opt/workdir/.scalr.terraform.rc && find /opt -name terraform.tfvars.json -type f && echo $AWS_ACCESS_KEY_ID"
  }
}

variable "hcl_value" {}
variable "hcl_value2" {}
variable "null" {}
variable "something" {}

output "hcl_value" {
  value = var.hcl_value
}

output "hcl_value2" {
  value = var.hcl_value2
}
output "null" {
  value = var.null
}
output "something" {
  value = var.something
}