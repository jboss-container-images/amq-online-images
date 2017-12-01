#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
# unpack
{
	cd /opt/app-root/src
	unzip "$SOURCES_DIR/nodejs-rhea.zip"
}

. /opt/rh/rh-nodejs4/enable
npm install nodejs-rhea-0.2.5-2/node_modules/rhea
npm install debug
