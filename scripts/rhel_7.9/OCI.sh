#!/bin/bash -eux

# Edit kernel boot parameters and regenerate GRUB config file.
sed -i.bak 's/GRUB_CMDLINE_LINUX="[^"]*/& net.ifnames=0 biosdevname=0/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# Correct the ifcfg file condiguration, rename to eth0.
sed -i.bak 's/NAME="enp0s3"/NAME="eth0"/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i.bak 's/DEVICE="enp0s3"/DEVICE="eth0"/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
mv /etc/sysconfig/network-scripts/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-eth0
