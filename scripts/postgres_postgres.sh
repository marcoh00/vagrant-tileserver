#!/bin/bash

set -e

echo "--- Running PostgresSQL & PostGIS setup ---"

echo "-> Create OSM user"
createuser osm

echo "-> Set password"
psql -c "ALTER USER osm WITH PASSWORD 'osm'"

echo "-> Create OSM database"
createdb -E UTF-8 -O osm osm

echo "-> Activating PostGIS extensions"
psql -d osm -c "CREATE EXTENSION postgis;"
psql -d osm -c "CREATE EXTENSION postgis_topology;"

