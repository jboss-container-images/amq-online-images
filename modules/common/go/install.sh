#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/

# unpack
mkdir -p /opt/
for zip in $(find "${SOURCES_DIR}" -name "*.zip")
do
    unzip ${zip} -d /opt
done
