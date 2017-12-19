#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

cd ${SOURCES_DIR}
rpm -ih -r "${SOURCES_DIR}" "${SOURCES_DIR}/nodejs-amqmaas-agent-zip.rpm"
{
	mkdir -p /opt/app-root/src/
	unzip /tmp/artifacts/usr/share/doc/nodejs-amqmaas-agent-1.0.0-4.zip -d /opt/app-root/src/
}

cd /opt/app-root/src/nodejs-amqmaas-agent-1.0.0-4
[ -f /opt/rh/rh-nodejs4/enable ] && . /opt/rh/rh-nodejs4/enable

mv node_modules/agent/* .
rm -rf node_modules/*

npm install

chown -R 1001:root /opt/app-root
