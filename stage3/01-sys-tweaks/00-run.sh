#!/bin/bash -e

# Add user pi to bluetooth group.
on_chroot << \EOF
adduser pi bluetooth
EOF

# Allow non-root users to control backlight power and brightness.
install -v -m 644 files/backlight-permissions.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

# Disable console blanking.
on_chroot << \EOF
echo `cat /boot/cmdline.txt` consoleblank=0 > /boot/cmdline.txt
EOF

# Change sound volume.
install -v -m 644 files/asound.state "${ROOTFS_DIR}/var/lib/alsa/asound.state"
