#!/bin/bash -e

# Copy app.
cp -rp files/blas/ "${ROOTFS_DIR}/home/pi/blas/"
chown -R 1000:1000 "${ROOTFS_DIR}/home/pi/blas/"

# Copy config file.
install -v -m 644 -o 1000 -g 1000 files/config.json "${ROOTFS_DIR}/home/pi/blas/config.json"

# Install pip.
on_chroot << \EOF
wget https://bootstrap.pypa.io/get-pip.py
su - -c "python /get-pip.py"
rm get-pip.py
EOF

# Install requirements.
on_chroot << \EOF
su - -c "python2.7 -m pip install -r /home/pi/blas/requirements.txt"
EOF

# Add Blas to supervisord configuration.
cat files/blas-supervisord.conf >> "${ROOTFS_DIR}/etc/supervisor/supervisord.conf"
