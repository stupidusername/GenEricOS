#!/bin/bash -e

# Disable wait for network at boot.
rm "${ROOTFS_DIR}/etc/systemd/system/dhcpcd.service.d/wait.conf"
