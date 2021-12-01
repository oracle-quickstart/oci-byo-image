#Variables declared in this file must be declared in the marketplace.yaml
#Provide a description to your variables.

############################
#  Hidden Variable Group   #
############################
variable "tenancy_ocid" {
}

variable "region" {
}

variable "compartment_ocid" {
}

############################
#  Compute Configuration   #
############################

variable "rhel8_x86_custom_image_id" {
}

variable "rhel8_aarch_custom_image_id" {
}

variable "rhel7_x86_custom_image_id" {
}

variable "rhel6_x86_custom_image_id" {
}

# only used for E3 Flex shape
variable "vm_flex_shape_ocpus" {
  description = "Flex Shape OCPUs"
  default     = 1
}

variable "availability_domain_name" {
  default     = ""
  description = "Availability Domain name, if non-empty takes precedence over availability_domain_number"
}

variable "availability_domain_number" {
  default     = 1
  description = "OCI Availability Domains: 1,2,3  (subject to region availability)"
}

variable "ssh_public_key" {
  description = "SSH Public Key"
}

variable "hostname_label" {
  default     = "simple"
  description = "DNS Hostname Label. Must be unique across all VNICs in the subnet and comply with RFC 952 and RFC 1123."
}

variable "aarch_shapes" {
    default = [
      "VM.Standard.A1.Flex"
     ]
}
variable "x86_shapes" {
    default = [
      "VM.Optimized3.Flex",
      "VM.Standard2.2",
      "VM.Standard.E2.2",
      "VM.Standard.E3.Flex",
      "VM.Standard.E4.Flex",
      "VM.DenseIO2.8"
    ]
}

#      "BM.Standard1.36"

############################
#  Network Configuration   #
############################

variable "subnet_id" {
}

variable "ssh_private_key" {
}