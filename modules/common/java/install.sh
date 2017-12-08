#!/bin/sh
set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

mv ${ADDED_DIR}/launch_java.sh /bin

chmod -R ug+x /bin/launch_java.sh
chown jboss:0 /bin/launch_java.sh
