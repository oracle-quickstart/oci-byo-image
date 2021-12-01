resource "oci_core_instance" "rhel8_aarch" {
  for_each = toset(var.aarch_shapes)

  availability_domain = local.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "rhel8_aarch-${replace(each.key, ".", "-")}"
  shape               = each.key

  dynamic "shape_config" {
    for_each = substr(each.key, -5, -1) == ".Flex" ? [2] : []
    content {
      ocpus = shape_config.value
    }
  }

  create_vnic_details {
    subnet_id              = var.subnet_id
    assign_public_ip       = true
    hostname_label         = "rhel8-aarch-${replace(each.key, ".", "-")}"
    skip_source_dest_check = false
  }

  source_details {
    source_type = "image"
    source_id   = var.rhel8_aarch_custom_image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(file("./scripts/example.sh"))
  }

}
