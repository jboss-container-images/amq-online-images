#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

DISTRO_NAME=apache-artemis

# unpack apache-artemis
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME-bin.tar.gz" -C /opt
	
	tar xzf "${SOURCES_DIR}/artemis-image.tar" -C /
	mv "${SOURCES_DIR}/shutdown-hook.jar" /shutdown-hook/shutdown-hook.jar
	mv "${SOURCES_DIR}/amqp-connector.jar" /shutdown-hook/amqp-connector.jar
	mv "${SOURCES_DIR}/sasl-delegation.jar" /shutdown-hook/sasl-delegation.jar
	mv ${ADDED_DIR}/shutdown-hook.sh /shutdown-hook/shutdown-hook.sh	
	mv ${ADDED_DIR}/dynamic_resources.sh /opt/apache-artemis-2.4.0/bin/dynamic_resources.sh
	mv ${ADDED_DIR}/launch.sh /opt/apache-artemis-2.4.0/bin/launch.sh
	mv ${ADDED_DIR}/partitionPV.sh /opt/apache-artemis-2.4.0/bin/partitionPV.sh
	mv ${ADDED_DIR}/probe.sh /opt/apache-artemis-2.4.0/bin/probe.sh
	
}

#For volume
mkdir -p /var/run/artemis/
chown 185 /var/run/artemis

chown -R 185:0 /home/jboss
chmod 0755 /home/jboss
chmod -R g+rwX /home/jboss