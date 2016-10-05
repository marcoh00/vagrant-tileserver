#!/bin/bash

set -e

echo "--- Setting up apache ---"

echo "-> Copy configuration files"
install -o root -m 644 $BASEDIR/config/apache/tile.load /etc/apache2/mods-available
install -o root -m 644 $BASEDIR/config/apache/mod_tile.conf /etc/apache2/sites-available

echo "-> Disable all enabled sites"
rm -rf /etc/apache2/sites-enabled/*

echo "-> Load mod_tile and serve it"
ln -s /etc/apache2/mods-available/tile.load /etc/apache2/mods-enabled/tile.load
ln -s /etc/apache2/sites-available/mod_tile.conf /etc/apache2/sites-enabled/mod_tile.conf

echo "-> Install simple javascript map"
rm /var/www/html/index.html
install -o root -m 644 $BASEDIR/config/apache/index.html /var/www/html

echo "-> Enable and start apache2 server"
systemctl enable apache2 > /dev/null
systemctl start apache2