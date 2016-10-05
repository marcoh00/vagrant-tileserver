# Vagrantfile for setting up a OpenStreetMap tileserver
## How does it work?

All you need to do is to clone the repository, place OpenStreetMap data files (.osm.pbf) of your choice inside the "blob" directory and run

    vagrant up

to fire up a fresh Ubuntu 16.04 LTS VM and provision it. Please note the provisioning script imports the OSM files using slim mode, so the OSM files have to be disjoint. After successful installation, Apache listens on localhost:8080 and serves OSM tiles, accessible via the /osm_tiles URI.
You can use any map viewer like [leaflet](http://leafletjs.com/) now to view the tiles. Alternatively, just visit [http://localhost:8080/index.html](http://localhost:8080/index.html) to see a rudimentary map.

## Configuration
In case you don't want to use the default settings, create a file named "settings.source" in the top directory (the one containing "Vagrantfile") and put your configuration options in there.

The following sample configuration represents the default options:

    export OSM_CARTO_CLONE_URL="https://github.com/gravitystorm/openstreetmap-carto.git"
    export MOD_TILE_CLONE_URL="https://github.com/openstreetmap/mod_tile.git"
    export MOD_TILE_DEST_PATH="/tmp/mod_tile"
    export CD_SHAPE_SCRIPT="/usr/share/openstreetmap-carto"
    export SHAPE_SCRIPT="./get-shapefiles.sh"
    export PROGRESS_DIR="/tmp"

- OSM_CARTO_CLONE_URL: A URL to the "openstreetmap-carto" git repository
- MOD_TILE_CLONE_URL: A URL to the "mod_tile" git repository
- MOD_TILE_DEST_PATH: Path to clone mod_tile to
- CD_SHAPE_SCRIPT: Change to this directory before executing SHAPE_SCRIPT
- SHAPE_SCRIPT: Script which is executed in the import process. Should yield a shapefile-populated data/ directory inside /usr/share/openstreetmap-carto
- PROGRESS_DIR: Directory which should hold "barrier" files (signaling which provision scripts were already executed successfully)

## Proxy
If you need to use a proxy server, set "http_proxy" environment variable on the host machine accordingly. Additionally, https_proxy and no_proxy variables will be honored (or else populated with sane default values).