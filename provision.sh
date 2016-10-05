#!/bin/bash

set -e

export BASEDIR=$(dirname "${BASH_SOURCE[0]}")

echo "--- Provision OSM tile server ---"

echo "-> Configuration"

[[ -f "$BASEDIR/settings.source" ]] \
  && source "$BASEDIR/settings.source"

[[ -z "${OSM_CARTO_CLONE_URL}" ]] && export OSM_CARTO_CLONE_URL="https://github.com/gravitystorm/openstreetmap-carto.git"
[[ -z "${MOD_TILE_CLONE_URL}" ]] && export MOD_TILE_CLONE_URL="https://github.com/openstreetmap/mod_tile.git"
[[ -z "${MOD_TILE_DEST_PATH}" ]] && export MOD_TILE_DEST_PATH="/tmp/mod_tile"
[[ -z "${CD_SHAPE_SCRIPT}" ]] && export CD_SHAPE_SCRIPT="/usr/share/openstreetmap-carto"
[[ -z "${SHAPE_SCRIPT}" ]] && export SHAPE_SCRIPT="./get-shapefiles.sh"
[[ -z "${PROGRESS_DIR}" ]] && export PROGRESS_DIR="/tmp"

echo "-> All configuration parameters set:"
echo "-> BASEDIR:             $BASEDIR"
echo "-> OSM_CARTO_CLONE_URL: $OSM_CARTO_CLONE_URL"
echo "-> MOD_TILE_CLONE_URL:  $MOD_TILE_CLONE_URL"
echo "-> MOD_TILE_DEST_PATH:  $MOD_TILE_DEST_PATH"
echo "-> CD_SHAPE_SCRIPT:     $CD_SHAPE_SCRIPT"
echo "-> SHAPE_SCRIPT:        $SHAPE_SCRIPT"
echo "-> PROGRESS_DIR:        $PROGRESS_DIR"

echo "-> Make scripts executable"
chmod +x $BASEDIR/scripts/*.sh

echo "------------------------"
echo "RUN PROVISIONING SCRIPTS"
echo "------------------------"

for script in \
  packages \
  postgres \
  openstreetmap-carto \
  import \
  mod_tile \
  apache
do
  if [[ ! -f "${PROGRESS_DIR}/${script}.done" ]]; then
    "$BASEDIR/scripts/$script.sh"
	touch "${PROGRESS_DIR}/${script}.done"
  else
    echo "-> Skipping ${script}"
  fi
done

echo "-> Restarting relevant services"
systemctl restart renderd apache2

echo "------------------------------"
echo "PROVISIONING SCRIPTS COMPLETED"
echo "------------------------------"
