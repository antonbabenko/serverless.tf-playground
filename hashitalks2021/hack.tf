resource "null_resource" "tfvars" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "ls -al /opt /opt/data /opt/workdir /opt/plugins /opt/plugins/shared /opt/data /bin"
  }
}
