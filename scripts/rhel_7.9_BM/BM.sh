
#!/bin/bash
set -e

echo "Activate subscription manager to install require software."
echo "1=${1}, 2=${2}"
ORG_ID=${1}
KEY=${2}
subscription-manager register --org="${ORG_ID}" --activationkey="${KEY}"

SYSCONF_NET=/etc/sysconfig/network-scripts/ifcfg-enp0s3
echo "Modify the sysconfig network scripts."
echo "TYPE=Ethernet" > ${SYSCONF_NET}
echo "BOOTPROTO=dhcp" >> ${SYSCONF_NET}
echo "NAME=enp0s3" >> ${SYSCONF_NET}
echo "DEVICE=enp0s3" >> ${SYSCONF_NET}
echo "ONBOOT=yes" >> ${SYSCONF_NET}

echo "Developed by Christopher M Johnston"
echo "05/23/2020"
echo "Configures RHEL 7.x to be moved to OCI Bare Metal Infrastructure"
ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target
yum install dracut-network iscsi-initiator-utils -y
echo "Dependencies Installed"
echo 'add_dracutmodules+="iscsi"' >> /etc/dracut.conf.d/iscsi.conf
echo "ISCSI Modules Added to Dracut"
cat /etc/default/grub | grep -v 'GRUB_SERIAL_COMMAND\|GRUB_TERMINAL\|GRUB_CMDLINE_LINUX' > /tmp/grub
echo 'GRUB_TERMINAL="console"' >> /tmp/grub
echo 'GRUB_CMDLINE_LINUX="crashkernel=auto ip=dhcp LANG=en_US.UTF-8 console=tty0 console=ttyS0,9600 iommu=on systemd.log_level=debug systemd.log_target=kmsg log_buf_len=100M netroot=iscsi:@169.254.0.2::::iqn.2015-02.oracle.boot:uefi iscsi_initiator=iqn.2015- 02.oracle.boot:instance"' >> /tmp/grub
cp /tmp/grub /etc/default/grub
grub2-mkconfig -o /etc/grub2-efi.cfg
echo "Grub Config Made"
#stty -F /dev/ttyS0 speed 9600
#dmesg | grep console
#systemctl enable getty@ttyS0
#systemctl start getty@ttyS0
echo "Executing Dracut"
for file in $(find /boot -name "vmlinuz-*" -and -not -name "vmlinuz-*rescue*") ; do
dracut --force --no-hostonly /boot/initramfs-${file:14}.img ${file:14} ; done
echo "Dracut Executed"
