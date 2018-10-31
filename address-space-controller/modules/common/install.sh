#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

DISTRO_NAME=address-space-controller


# unpack
{
    mv "$SOURCES_DIR/address-space-controller.jar" /opt
    mv "$ADDED_DIR/addressplans" /
    mv "$ADDED_DIR/addressspaceplans" /
    mv "$ADDED_DIR/brokeredinfraconfigs" /
    mv "$ADDED_DIR/standardinfraconfigs" /
}
