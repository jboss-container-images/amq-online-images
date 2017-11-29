#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=apache-artemis

# unpack apache-artemis
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME-bin.tar.gz"
	ls -l
    cp -r "$DISTRO_NAME-2.4.0" /opt
    rm -r "$DISTRO_NAME-2.4.0"
}

#For volume
mkdir -p /var/run/artemis/
chown 185 /var/run/artemis
