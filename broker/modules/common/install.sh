#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=apache-artemis

# unpack apache-artemis
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME-bin.tar.gz" -C /opt
	
	tar xzf "${SOURCES_DIR}/artemis-image.tar" -C /
}

#For volume
mkdir -p /var/run/artemis/
chown 185 /var/run/artemis

chown -R 185:0 /home/jboss
chmod 0755 /home/jboss
chmod -R g+rwX /home/jboss