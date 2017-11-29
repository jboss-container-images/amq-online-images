#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=topic-forwarder


# unpack
{
	mv "${SOURCES_DIR}/topic-forwarder.jar" /opt
}

