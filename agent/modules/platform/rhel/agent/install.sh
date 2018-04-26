#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added
DIST_NAME="nodejs-amqmaas-agent-1.0.0-*"
{
	mkdir -p /opt/app-root/src/
	unzip "/usr/share/${DIST_NAME}.zip" -d /opt/app-root/src/
}

{
	cd /opt/app-root/src/${DIST_NAME}
	mv node_modules/agent/* /opt/app-root/src
	mv node_modules /opt/app-root/src
	mv "${ADDED_DIR}/launch_node.sh" /opt/app-root/src/bin/
}

groupadd -r jboss -g 185 && useradd -u 185 -r -g jboss -m -d /home/jboss -s /sbin/nologin -c "JBoss user" jboss
chown -R jboss:root /opt/app-root