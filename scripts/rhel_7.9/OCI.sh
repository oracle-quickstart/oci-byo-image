#!/bin/bash -x

###############################################################
## Edit kernel boot parameters and regenerate GRUB config file.
###############################################################
sed -i.bak 's/GRUB_CMDLINE_LINUX="[^"]*/& net.ifnames=0 biosdevname=0/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

###############################################################
## Correct the ifcfg file condiguration, rename to eth0.
###############################################################
sed -i.bak 's/NAME="enp0s3"/NAME="eth0"/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
sed -i.bak 's/DEVICE="enp0s3"/DEVICE="eth0"/' /etc/sysconfig/network-scripts/ifcfg-enp0s3
mv /etc/sysconfig/network-scripts/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-eth0

###############################################################
## Various sudo and root password related things.
###############################################################
echo "opc        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/opc
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sed -i "s/^PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
passwd -d root

###############################################################
## Install Oracle Cloud agent.
###############################################################
curl -O https://objectstorage.us-phoenix-1.oraclecloud.com/p/qcFC8UosSyfuCqRaHX1iN3-0GAXhWauuS7jo6bdwhHIQEhhBiMEs_RrMsqind6B5/n/imagegen/b/agents/o/oracle-cloud-agent-1.16.0-6051.el7.x86_64.rpm -v
yum install -y oracle-cloud-agent-1.16.0-6051.el7.x86_64.rpm
rm oracle-cloud-agent-1.16.0-6051.el7.x86_64.rpm

###############################################################
## We need the 'jq' package for some exit-hook dhcp scripts.
###############################################################
curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y epel-release-latest-7.noarch.rpm
yum install -y jq
epel_release=`rpm -qa | grep epel-release`
yum remove -y ${epel_release}
rm -f epel-release-latest-7.noarch.rpm

###############################################################
## Download and install additional cloud-init scripts taken from
## the equivalent version on Oracle Linux platforms.
###############################################################
curl -X GET https://objectstorage.us-ashburn-1.oraclecloud.com/p/RKkf7Hz_kOloIIhw564-cz8R-tIW0qkIJkDFpsXtwuH1rJDvbTxvo48sfeIzdrYQ/n/partners/b/RHEL/o/10_updates_policy.cfg.7.9 --output /etc/cloud/cloud.cfg.d/10_updates_policy.cfg
curl -X GET https://objectstorage.us-ashburn-1.oraclecloud.com/p/RKkf7Hz_kOloIIhw564-cz8R-tIW0qkIJkDFpsXtwuH1rJDvbTxvo48sfeIzdrYQ/n/partners/b/RHEL/o/99_oci_cloud.cfg.7.9 --output /etc/cloud/cloud.cfg.d/99_oci_cloud.cfg

###############################################################
## Download and install additional dhcp scripts taken from
## the equivalent version on Oracle Linux platforms.
###############################################################
mkdir -p /etc/dhcp/exit-hooks.d
curl -X GET https://objectstorage.us-ashburn-1.oraclecloud.com/p/RKkf7Hz_kOloIIhw564-cz8R-tIW0qkIJkDFpsXtwuH1rJDvbTxvo48sfeIzdrYQ/n/partners/b/RHEL/o/dhclient-exit-hooks.7.9 --output /etc/dhcp/dhclient-exit-hooks
curl -X GET https://objectstorage.us-ashburn-1.oraclecloud.com/p/RKkf7Hz_kOloIIhw564-cz8R-tIW0qkIJkDFpsXtwuH1rJDvbTxvo48sfeIzdrYQ/n/partners/b/RHEL/o/dhclient-exit-hook-set-hostname.sh.7. 9 --output /etc/dhcp/exit-hooks.d/dhclient-exit-hook-set-hostname.sh
curl -X GET https://objectstorage.us-ashburn-1.oraclecloud.com/p/RKkf7Hz_kOloIIhw564-cz8R-tIW0qkIJkDFpsXtwuH1rJDvbTxvo48sfeIzdrYQ/n/partners/b/RHEL/o/oci-hostname.conf.7.9 --output /etc/oci-hostname.conf
chmod +x /etc/dhcp/dhclient-exit-hooks
chmod +x /etc/dhcp/exit-hooks.d/dhclient-exit-hook-set-hostname.sh
