#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=standard-controller


# unpack
{
    mv "$SOURCES_DIR/standard-controller.jar" /opt
}