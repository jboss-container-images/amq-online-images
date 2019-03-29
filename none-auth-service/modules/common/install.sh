#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=none-authservice


# unpack
{
    mv "$SOURCES_DIR/none-authservice.jar" /opt
}
