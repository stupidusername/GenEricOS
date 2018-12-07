#!/bin/bash -e

# Copy app.
cp -rp files/eric-*/ "${ROOTFS_DIR}/home/pi/eric/"
chown -R 1000:1000 "${ROOTFS_DIR}/home/pi/eric/"

# Copy Kivy config files.
install -v -d -o 1000 -g 1000 "${ROOTFS_DIR}/home/pi/.kivy/"
install -v -m 644 -o 1000 -g 1000 files/config.ini "${ROOTFS_DIR}/home/pi/.kivy/config.ini"

# Add service to start app at boot.
install -v -m 644 files/eric.service "${ROOTFS_DIR}/etc/systemd/system/eric.service"
on_chroot << \EOF
ln -s /etc/systemd/system/eric.service /etc/systemd/system/multi-user.target.wants/
EOF
