#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

# unpack
{
    mkdir -p /opt/
    unzip "${SOURCES_DIR}/enmasse-controller-manager.zip" -d /opt
}
