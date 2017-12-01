#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=keycloak-controller


# unpack
{
	mv "${SOURCES_DIR}/$DISTRO_NAME.jar" /opt  
}

