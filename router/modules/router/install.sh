#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=router


# unpack
{
	mkdir -p /etc/qpid-dispatch/
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tgz" -C /etc/qpid-dispatch/
}

chown -R 185:0 /etc/qpid-dispatch/

