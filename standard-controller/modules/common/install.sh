#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=standard-controller


# unpack
{
    mkdir -p /opt/
    unzip "${SOURCES_DIR}/standard-controller.zip" -d /opt
}
