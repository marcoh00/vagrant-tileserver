#!/bin/bash

set -e

echo "--- Building and configuring mod_tile ---"

echo "-> Changing directory"
cd $MOD_TILE_DEST_PATH

echo "-> Generate configure script"
./autogen.sh > /dev/null

echo "-> Calling configure"
./configure --prefix=/usr > /dev/null

echo "-> Compile"
make -j 4 > /dev/null

echo "-> Install"
make install > /dev/null

echo "-> Install mod_tile"
make install-mod_tile > /dev/null

echo "-> Copy renderd configuration"
rm /usr/etc/renderd.conf || true
mkdir -p /usr/etc
install -o root -m 644 $BASEDIR/config/renderd/renderd.conf /usr/etc/renderd.conf

echo "-> Create missing directories"
mkdir -p /var/lib/mod_tile /var/run/renderd

echo "-> Installing systemd unit files"
install -o root -m 644 $BASEDIR/config/systemd/renderd.{service,socket} /lib/systemd/system
install -o root -m 644 $BASEDIR/config/systemd/renderd.conf /usr/lib/tmpfiles.d

echo "-> Enabling and starting renderd"
systemctl enable renderd > /dev/null
systemctl start renderd