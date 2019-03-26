#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)

DISTRO_NAME=address-space-controller


# unpack
{
    mkdir -p /opt/
    unzip "${SOURCES_DIR}/address-space-controller.zip" -d /opt
}
