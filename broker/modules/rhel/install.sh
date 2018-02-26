#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

DISTRO_NAME=artemis-image

# unpack 
{
	mkdir -p /opt/apache-artemis-2.4.0/bin
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tar.gz" -C /
}
