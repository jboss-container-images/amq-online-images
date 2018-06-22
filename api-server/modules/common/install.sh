#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=api-server


# unpack
{
    mv "$SOURCES_DIR/api-server.jar" /opt
}
