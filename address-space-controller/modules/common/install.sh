#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=address-space-controller


# unpack
{
    mv "$SOURCES_DIR/address-space-controller.jar" /opt
}
