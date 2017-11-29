#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
# unpack
{
	cd /opt/app-root/src
	unzip "$SOURCES_DIR/nodejs-rhea.zip"
}

. /opt/rh/rh-nodejs4/enable
npm install nodejs-rhea-1.2.2-1/node_modules/rhea
npm install debug
