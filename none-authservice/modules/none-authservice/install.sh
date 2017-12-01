#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=none-authservice


# unpack
{
	mkdir -p /opt/app-root/src
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tgz" -C /opt/app-root/src
}
chown -R 185:0 /opt/app-root/src

