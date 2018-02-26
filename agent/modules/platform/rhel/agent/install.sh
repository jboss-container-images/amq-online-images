#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

{
	cd ${SOURCES_DIR}
	rpm -ih -r "${SOURCES_DIR}" "${SOURCES_DIR}/nodejs-amqmaas-agent-zip.rpm"
	mkdir -p /opt/app-root/src/
	unzip /tmp/artifacts/usr/share/doc/nodejs-amqmaas-agent-1.0.0-7.zip -d /opt/app-root/src/
}


{
	cd /opt/app-root/src/nodejs-amqmaas-agent-1.0.0-7
	mv node_modules/agent/* /opt/app-root/src
	mv node_modules /opt/app-root/src
	mv "${ADDED_DIR}/launch_node.sh" /opt/app-root/src/bin/
}

groupadd -r jboss -g 185 && useradd -u 185 -r -g jboss -m -d /home/jboss -s /sbin/nologin -c "JBoss user" jboss
chown -R 1001:root /opt/app-root
