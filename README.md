# Packer Templates for OCI

## Overview

This repository contains templates various various images that can be exported to OCI

## Building the Vagrant Boxes

```
## Usage
$> packer build <packer_template>

## Example 
$> packer build debian-10.6-i386.json
```

## Export Image to OCI
Once complete, the image can be exported to an Object Storage bucket in your OCI account. The following commands will export the image, create a custom image, and spin up an instance. *NOTE: You must link your VirtualBox account with your OCI account for this command to work. Those instructions can be found [here](http://www.oracle.com/us/technologies/virtualization/oracle-vm-vb-oci-export-20190502-5480003.pdf#%5B%7B%22num%22%3A47%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C51%2C727%2C0%5D).*

```
## Export image to OCI
$> VBoxManage export debian-10.6-12997... \
      --output OCI:// \
      --cloud 0 \
      --vmname fedora_32_vb \
      --cloudprofile DEFAULT \
      --cloudbucket vbox-upload \
      --cloudlaunchmode PARAVIRTUALIZED \
      --cloudshape VM.Standard2.1 \
      --clouddomain IYfK:US-ASHBURN-AD-1 \
      --clouddisksize 120 \
      --cloudocivcn ocid1.vcn.oc1.iad.amaaa... \
      --cloudocisubnet ocid1.subnet.oc1.iad.aaaaa... \
      --cloudkeepobject true \
      --cloudlaunchinstance true \
      --cloudpublicip true
```
