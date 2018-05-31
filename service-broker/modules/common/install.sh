#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=service-broker


# unpack
{
    mv "$SOURCES_DIR/service-broker.jar" /opt
}
