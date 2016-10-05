#!/bin/bash

set -e
export DEBIAN_FRONTEND=noninteractive

echo "--- Setting up files and packages ---"

echo "-> Update package lists"
apt-get update > /dev/null

echo "-> Upgrade system"
apt-get -y dist-upgrade > /dev/null

echo "-> Install basic tools"
apt-get -y install git-core unzip curl patch build-essential autoconf > /dev/null

echo "-> Install OSM tools"
apt-get -y install osm2pgsql libmapnik3.0 libmapnik-dev mapnik-utils > /dev/null

echo "-> Install dependend packages"
apt-get -y install fonts-noto fonts-dejavu unifont python-yaml > /dev/null

echo "-> Install NodeJS stack"
apt-get -y install nodejs nodejs-legacy npm > /dev/null

echo "-> Install PostgreSQL/PostGIS stack"
apt-get -y install  postgresql-9.5 postgresql-9.5-postgis-2.2 > /dev/null

echo "-> Install Apache stack"
apt-get install -y apache2 apache2-dev > /dev/null

echo "-> Install carto"
npm -g install carto > /dev/null

echo "-> Git clone openstreetmap-carto into /usr/share"
git clone "$OSM_CARTO_CLONE_URL" /usr/share/openstreetmap-carto > /dev/null

echo "-> Git clone mod_tile source code into $MOD_TILE_DEST_PATH"
mkdir -p $MOD_TILE_DEST_PATH
git clone "$MOD_TILE_CLONE_URL" $MOD_TILE_DEST_PATH > /dev/null
