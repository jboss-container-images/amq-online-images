#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

DISTRO_NAME=apache-artemis

# unpack apache-artemis
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME-bin.tar.gz" -C /opt
	if [ ! -d /opt/apache-artemis-2.4.0 ]; then
		mv /opt/$DISTRO_NAME* /opt/apache-artemis-2.4.0
	fi
	
	mkdir -p /shutdown-hook
#	mkdir -p /opt/apache-artemis-2.4.0/bin/launch.sh
	mv "${ADDED_DIR}/config_templates" /
	mv ${ADDED_DIR}/shutdown-hook.sh /shutdown-hook/shutdown-hook.sh	
	mv ${ADDED_DIR}/launch.sh /opt/apache-artemis-2.4.0/bin/launch.sh
	mv ${ADDED_DIR}/probe.sh /opt/apache-artemis-2.4.0/bin/probe.sh
}

#For volume
mkdir -p /var/run/artemis/
chown 185 /var/run/artemis

chown -R 185:0 /home/jboss
chmod 0755 /home/jboss
chmod -R g+rwX /home/jboss
chown -R 185:0 /opt/apache-artemis-2.4.0/bin
chmod 0755 /opt/apache-artemis-2.4.0/bin/*
