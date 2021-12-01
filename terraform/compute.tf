resource "oci_core_instance" "instances" {
  count               = length(var.versions) * length(var.x86_shapes)

  availability_domain = local.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "${var.versions[floor(count.index / length(var.x86_shapes))]}-${replace(var.x86_shapes[count.index % length(var.x86_shapes)], ".", "-")}"
  shape               = "${var.x86_shapes[count.index % length(var.x86_shapes)]}"

  dynamic "shape_config" {
    for_each = substr("${var.x86_shapes[count.index % length(var.x86_shapes)]}", -5, -1) == ".Flex" ? [2] : []
    content {
      ocpus = shape_config.value
    }
  }

  create_vnic_details {
    subnet_id              = var.subnet_id
    assign_public_ip       = true
    display_name        = "${var.versions[floor(count.index / length(var.x86_shapes))]}-${replace(var.x86_shapes[count.index % length(var.x86_shapes)], ".", "-")}"
    skip_source_dest_check = false
  }

  source_details {
    source_type = "image"
    source_id   = lookup(var.custom_ocids , "${var.versions[floor(count.index / length(var.x86_shapes))]}", null)
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = base64encode(file("./scripts/example.sh"))
  }

}
