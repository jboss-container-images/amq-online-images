#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=address-controller


# unpack
{
    mv "$SOURCES_DIR/address-controller.jar" /opt
}