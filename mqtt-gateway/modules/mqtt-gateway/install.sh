#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=mqtt-gateway


# unpack
{
	mv "${SOURCES_DIR}/mqtt-gateway.jar" /opt
}

