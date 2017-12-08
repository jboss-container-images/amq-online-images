#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

#install rhea
{
	rpm -iv "${SOURCES_DIR}/nodejs-rhea-zip.rpm"
	cd /opt/app-root/src
	unzip /usr/share/doc/nodejs-rhea-0.2.5-2.zip
}

. /opt/rh/rh-nodejs4/enable
npm install nodejs-rhea-0.2.5-2/node_modules/rhea
npm install debug
