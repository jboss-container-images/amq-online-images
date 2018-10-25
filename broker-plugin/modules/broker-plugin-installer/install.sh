#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added
BROKER_PLUGIN_DIR=/opt/amq/broker-plugin

{
    mkdir -p ${BROKER_PLUGIN_DIR}/shutdown-hook
    mkdir -p ${BROKER_PLUGIN_DIR}/bin
    mkdir -p ${BROKER_PLUGIN_DIR}/lib
    mkdir -p ${BROKER_PLUGIN_DIR}/jmx_exporter

    mv ${ADDED_DIR}/config_templates ${BROKER_PLUGIN_DIR}
    mv ${ADDED_DIR}/shutdown-hook.sh ${BROKER_PLUGIN_DIR}/shutdown-hook/shutdown-hook.sh
    mv ${ADDED_DIR}/init-broker.sh ${BROKER_PLUGIN_DIR}/bin/init-broker.sh
    mv ${ADDED_DIR}/launch-broker.sh ${BROKER_PLUGIN_DIR}/bin/launch-broker.sh
    mv ${ADDED_DIR}/probe.sh ${BROKER_PLUGIN_DIR}/bin/probe.sh
 
    mv ${SOURCES_DIR}/amqp-connector.jar ${BROKER_PLUGIN_DIR}/lib/amqp-connector.jar
    mv ${SOURCES_DIR}/sasl-delegation.jar ${BROKER_PLUGIN_DIR}/lib/sasl-delegation.jar
    mv ${SOURCES_DIR}/jmx-exporter.jar ${BROKER_PLUGIN_DIR}/jmx_exporter/jmx-exporter.jar

    mv ${SOURCES_DIR}/netty-tcnative-boringssl-static.jar ${BROKER_PLUGIN_DIR}/lib/
    mv ${SOURCES_DIR}/netty-tcnative-boringssl-static-linux-x86_64.jar ${BROKER_PLUGIN_DIR}/lib/

}

chown -R 185:0 /home/jboss
chmod 0755 /home/jboss
chmod -R g+rwX /home/jboss
chown -R 185:0 ${BROKER_PLUGIN_DIR}
chmod 0755 ${BROKER_PLUGIN_DIR}/bin/*
