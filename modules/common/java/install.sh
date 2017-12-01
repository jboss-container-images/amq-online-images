#!/bin/sh
set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

mv ${ADDED_DIR}/launch_java.sh /bin
mv ${ADDED_DIR}/dynamic_resources.sh /bin

chmod -R ug+x /bin/launch_java.sh
chown jboss:0 /bin/launch_java.sh

chmod -R ug+x /bin/dynamic_resources.sh
chown jboss:0 /bin/dynamic_resources.sh