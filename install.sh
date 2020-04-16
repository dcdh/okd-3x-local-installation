#!/bin/bash

# Ensure virtualization is available on host
if ! lscpu | grep 'VT-x'
then
  echo "CPU does not support virtualization"
  exit 1
fi

# install necessary package
sudo yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install -y && \
  sudo yum install ansible python3 -y && \
  # Update / Install needed package for qemu following fail to use fw_cfg https://www.spinics.net/lists/centos/msg166715.html
  sudo yum install centos-release-qemu-ev qemu-kvm-ev -y

# enable and start libvirt
sudo systemctl enable libvirtd && \
  sudo systemctl start libvirtd
