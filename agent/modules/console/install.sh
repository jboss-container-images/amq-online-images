#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=agent


# unpack
{
	mkdir -p /opt/app-root/src/	
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tgz" -C /opt/app-root/src/
}

cd /opt/app-root/src
[ -f /opt/rh/rh-nodejs4/enable ] && . /opt/rh/rh-nodejs4/enable
npm install
	
chown -R 1001:root /opt/app-root
