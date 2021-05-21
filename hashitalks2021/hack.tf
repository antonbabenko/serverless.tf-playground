resource "null_resource" "tfvars" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "ls -al /opt /opt/data /opt/workdir /opt/plugins /opt/plugins/shared /opt/data /bin /opt/workdir/.config /opt/workdir/.config/git && cat /opt/workdir/scalr_override.tf.json /opt/workdir/.scalr.terraform.rc"
  }
}
