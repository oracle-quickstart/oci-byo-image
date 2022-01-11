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

#rhel6_x86
#rhel7_x86
#rhel8_x86
#rhel8_aarch
variable "versions" {
  default = [
      "rhel7_x86_iso",
  ]
}

variable custom_ocids {
  type = map
  default = {
    "rhel6_x86"     = "ocid1.image.oc1.iad.aaaaaaaaaae6c5vgx46oghzupr4zzp4w7oez4jab3aupaqzhm7ohzrsgadua"
    "rhel7_x86"     = "ocid1.image.oc1.iad.aaaaaaaaucv3l5qzi6z7peh4pkamprr2vrw5gqbodfpq7676ch6fi5fo5myq"
    "rhel7_x86_iso" = "ocid1.image.oc1.iad.aaaaaaaaur4ybqmgislzjpqjgkbmjojfo4wr72lrsn6umci67bxwwwutqn5a"
    "rhel8_aarch"   = "ocid1.image.oc1.iad.aaaaaaaatr2taxrzf6feolghswset54at7lqxkz4xizcpymbsvl6ovunthlq"
    "rhel8_x86"     = "ocid1.image.oc1.iad.aaaaaaaahrmd7c5susd5lrg7bquqw7fsi5wpc5kgii3vhrvxgbpvqrafiveq"
    "rhel8_x86_iso" = "ocid1.image.oc1.iad.aaaaaaaad2bykk6jt3i7gghgcbunooens3scigoeszukqzsxedk5cyipdcna"
  }
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

variable "shapes" {
    default = [
      "VM.DenseIO2.8",
      "VM.DenseIO2.16",
      "VM.DenseIO2.24",
    ]
}

/*
valid shapes:
      "VM.Standard1.1",
      "VM.Standard1.16",
      "VM.Standard1.2",
      "VM.Standard1.8",
      "VM.Standard1.4",
      "VM.DenseIO2.8",
      "VM.DenseIO2.16",
      "VM.DenseIO2.24",
      "VM.Standard2.1",
      "VM.Standard2.16",
      "VM.Standard2.2",
      "VM.Standard2.24",
      "VM.Standard2.4",
      "VM.Standard2.8",
      "VM.Standard.E2.1",
      "VM.Standard.E2.2",
      "VM.Standard.E2.4",
      "VM.Standard.E2.8",
      "VM.Standard.E3.Flex",
      "VM.Standard.E4.Flex",
      "VM.Optimized3.Flex"

BM shapes:
      "BM.Standard2.52",
      "BM.DenseIO2.52",
      "BM.Standard.E3.128",
      "BM.Standard.E2.64",
      "BM.Standard1.36",
      "BM.HighIO1.36",
      "BM.DenseIO1.36",

invalid shapes
      "VM.Standard3.Flex",
      "DVH.Standard2.52",
      "DVH.Standard.E2.64",
      "DVH.Standard.E3.128",
      "DVH.DenseIO2.52"
      "VM.DenseIO1.4",
      "VM.DenseIO1.16",
      "VM.DenseIO1.8",
      "VM.Standard.E2.1.Micro",

Specialty Shapes:
- VM.GPU2.1
- VM.GPU3.1
- VM.GPU3.2
- VM.GPU3.4
- BM.GPU2.2
- BM.GPU3.8
- BM.GPU4.8
- BM.HPC2.36


variable "complete_x86_shapes" {
    default = [
      "VM.Standard1.1",
      "VM.Standard1.16",
      "VM.Standard1.2",
      "VM.Standard1.8",
      "VM.Standard1.4",
      "VM.DenseIO1.16",
      "VM.DenseIO1.4",
      "VM.DenseIO1.8",
      "VM.DenseIO2.16",
      "VM.DenseIO2.24",
      "VM.DenseIO2.8",
      "VM.Standard2.1",
      "VM.Standard2.16",
      "VM.Standard2.2",
      "VM.Standard2.24",
      "VM.Standard2.4",
      "VM.Standard2.8",
      "VM.Standard.E2.1",
      "VM.Standard.E2.2",
      "VM.Standard.E2.4",
      "VM.Standard.E2.8",
      "VM.Standard.E2.1.Micro",
      "VM.Standard.E3.Flex",
      "BM.Standard2.52",
      "BM.DenseIO2.52",
      "BM.Standard.E3.128",
      "BM.Standard.E2.64",
      "BM.Standard1.36",
      "BM.HighIO1.36",
      "BM.DenseIO1.36",
      "VM.Standard.E4.Flex",
      "BM.Standard.E4.128",
      "VM.Optimized3.Flex",
      "VM.Standard3.Flex",
      "BM.Optimized3.36",
      "BM.Standard3.64",
      "DVH.Standard2.52",
      "DVH.Standard.E2.64",
      "DVH.Standard.E3.128",
      "DVH.DenseIO2.52"
    ]
}
*/




#      "BM.Standard1.36"

############################
#  Network Configuration   #
############################

variable "subnet_id" {
}

variable "ssh_private_key" {
}
