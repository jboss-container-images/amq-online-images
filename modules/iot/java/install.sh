#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

install --mode=0755 --owner=jboss --group=0 ${ADDED_DIR}/launch_java.sh /bin
install --mode=0755 --owner=jboss --group=0 ${ADDED_DIR}/java-default-options /bin
