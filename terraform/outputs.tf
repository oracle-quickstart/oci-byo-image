###
# compute.tf outputs
###

output "rhel8_x86_public_ips" {
  value = {
    for instance in oci_core_instance.rhel8_x86:
      "${instance.id} - ${instance.shape}" => instance.public_ip
  }
}

output "rhel8_aarch_public_ips" {
  value = {
    for instance in oci_core_instance.rhel8_aarch:
      "${instance.id} - ${instance.shape}" => instance.public_ip
  }
}

output "rhel7_x86_public_ips" {
  value = {
    for instance in oci_core_instance.rhel7_x86:
      "${instance.id} - ${instance.shape}" => instance.public_ip
  }
}

output "rhel6_x86_public_ips" {
  value = {
    for instance in oci_core_instance.rhel6_x86:
      "${instance.id} - ${instance.shape}" => instance.public_ip
  }
}
