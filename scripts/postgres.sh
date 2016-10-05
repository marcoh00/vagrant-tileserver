#!/bin/bash

set -e

echo "--- Running postgres setup as postgres ---"

echo "-> Starting PostgreSQL"
systemctl enable postgresql > /dev/null
systemctl start postgresql

echo "-> sudo -u postgres postgres.sh"
sudo -u postgres "$BASEDIR/scripts/postgres_postgres.sh"
