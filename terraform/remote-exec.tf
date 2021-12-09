resource "null_resource" "compute-script" {
  count = length(oci_core_instance.instances)

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "cloud-user"
      host     = oci_core_instance.instances[count.index].public_ip
      private_key = "${file(var.ssh_private_key)}"
      timeout  = "10m"
    }
    inline = [
      "curl -sH \"Authorization: Bearer Oracle\" -L http://169.254.169.254/opc/v2/instance/ | grep \"shape\\\"\" | cut -d\" \" -f 5",
      "touch ~/hello.txt",
      "if [ -f ~/hello.txt ]; then echo ~/hello.txt exists ; else echo ERROR ~/hello.txt done not exist; fi"
    ]
  }
}