#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=configserv


# unpack
{
	mv "${SOURCES_DIR}/$DISTRO_NAME.jar" /opt
}

