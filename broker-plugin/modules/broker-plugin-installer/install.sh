#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
BROKER_PLUGIN_DIR=/opt/broker-plugin

{
    mkdir -p ${BROKER_PLUGIN_DIR}/bin

    unzip "${SOURCES_DIR}/broker-plugin.zip" -d /
}

chown -R 185:0 /home/jboss
chmod 0755 /home/jboss
chmod -R g+rwX /home/jboss
chown -R 185:0 ${BROKER_PLUGIN_DIR}
chmod 0755 ${BROKER_PLUGIN_DIR}/bin/*
