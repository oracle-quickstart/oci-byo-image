###
# compute.tf outputs
###

output "public_ips" {
  #value = {
  #  for instance in oci_core_instance.instances:
  #    "count " => length(oci_core_instance.instances)...
  #}
  value = {
    "count = " = length(oci_core_instance.instances)
  }
}
