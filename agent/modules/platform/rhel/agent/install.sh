#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added
{
	mkdir -p /opt/app-root/src/
	unzip "${SOURCES_DIR}/agent-dist.zip" -d /opt/app-root/src/
}

{
	mv "${ADDED_DIR}/launch_node.sh" /opt/app-root/src/bin/
}

groupadd -r jboss -g 185 && useradd -u 185 -r -g jboss -m -d /home/jboss -s /sbin/nologin -c "JBoss user" jboss
chown -R jboss:root /opt/app-root
