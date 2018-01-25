#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
ARTIFACT_VERSION="1.0.0-6"

cd ${SOURCES_DIR}
rpm -ih -r "${SOURCES_DIR}" "${SOURCES_DIR}/nodejs-amqmaas-agent-zip.rpm"
{
	mkdir -p /opt/app-root/src/
	unzip /tmp/artifacts/usr/share/doc/nodejs-amqmaas-agent-${ARTIFACT_VERSION}.zip -d /opt/app-root/src/
}

cd /opt/app-root/src/nodejs-amqmaas-agent-${ARTIFACT_VERSION}
[ -f /opt/rh/rh-nodejs4/enable ] && . /opt/rh/rh-nodejs4/enable

mv node_modules/agent/* .
rm -rf node_modules/*

npm install

chown -R 1001:root /opt/app-root

