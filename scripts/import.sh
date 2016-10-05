#!/bin/bash

set -e

echo "--- Importing data ---"

echo "-> Downloading shapefiles"
cd "$CD_SHAPE_SCRIPT"
chmod +x "$SHAPE_SCRIPT"
eval "$SHAPE_SCRIPT"

echo "-> Import OpenStreetMap files into database"
cd /usr/share/openstreetmap-carto
for mapfile in $BASEDIR/blob/*.osm.pbf; do
  echo "-> Import: $mapfile"
  [[ -z "${OSM2PGSQL_FLAGS}" ]] && export OSM2PGSQL_FLAGS="-c"
  PGPASS=osm osm2pgsql $OSM2PGSQL_FLAGS -s -S openstreetmap-carto.style -d osm -U osm -H localhost "$mapfile"
  export OSM2PGSQL_FLAGS="-a"
done

