#!/bin/sh -eux

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=751636
apt-get install libpam-systemd

# Only add the secure path line if it is not already present
grep -q 'secure_path' /etc/sudoers \
  || sed -i -e '/Defaults\s\+env_reset/a Defaults\tsecure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' /etc/sudoers;

# Set up password-less sudo for the opc user
echo 'opc ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/opc;
chmod 440 /etc/sudoers.d/opc;

# Disable Predictable Network Interface names and use eth0
sed -i 's/en[[:alnum:]]*/eth0/g' /etc/network/interfaces;
sed -i 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 \1"/g' /etc/default/grub;
update-grub;

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" >> /etc/network/interfaces
