#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=queue-scheduler


# unpack
{
	mv "${SOURCES_DIR}/queue-scheduler.jar" /opt
}

