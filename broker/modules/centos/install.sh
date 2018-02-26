#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

DISTRO_NAME=artemis-image

# unpack 
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tar.gz" -C /
}

