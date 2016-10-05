#!/bin/bash

set -e

echo "--- Setting up openstreetmap-carto and generate mapnik.xml ---"

echo "-> Changing directory"
cd /usr/share/openstreetmap-carto

echo "-> Parameterize project.yaml file (patch)"
patch -p1 < $BASEDIR/config/openstreetmap-carto/osm-param-db.patch

echo "-> postgis connection settings"
sed -i "s/###DBNAME###/osm/" project.yaml
sed -i "s/###DBUSER###/osm/" project.yaml
sed -i "s/###DBPASSWORD###/osm/" project.yaml
sed -i "s/###DBHOST###/localhost/" project.yaml

echo "-> Generate project.mml"
python2 scripts/yaml2mml.py

echo "-> Generate mapnik.xml"
carto -a 3.0.9 project.mml > mapnik.xml
