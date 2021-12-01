resource "null_resource" "rhel7-x86-compute-script" {
  for_each = oci_core_instance.rhel7_x86

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "cloud-user"
      host     = oci_core_instance.rhel7_x86[each.key].public_ip
      private_key = "${file(var.ssh_private_key)}"
    }
    inline = [
      "echo 'remote-exec called'",
      "touch ~/hello.txt"
    ]
  }
}

resource "null_resource" "rhel8-x86-compute-script" {
  for_each = oci_core_instance.rhel8_x86

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "cloud-user"
      host     = oci_core_instance.rhel8_x86[each.key].public_ip
      private_key = "${file(var.ssh_private_key)}"
    }
    inline = [
      "echo 'remote-exec called'",
      "touch ~/hello.txt"
    ]
  }
}

resource "null_resource" "rhel8-aarch-compute-script" {
  for_each = oci_core_instance.rhel8_aarch

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "cloud-user"
      host     = oci_core_instance.rhel8_aarch[each.key].public_ip
      private_key = "${file(var.ssh_private_key)}"
    }
    inline = [
      "echo 'remote-exec called'",
      "touch ~/hello.txt"
    ]
  }
}

resource "null_resource" "rhel6-x86-compute-script" {
  for_each = oci_core_instance.rhel6_x86

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "cloud-user"
      host     = oci_core_instance.rhel6_x86[each.key].public_ip
      private_key = "${file(var.ssh_private_key)}"
    }
    inline = [
      "echo 'remote-exec called'",
      "touch ~/hello.txt"
    ]
  }
}