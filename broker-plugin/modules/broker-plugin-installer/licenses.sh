#!/bin/sh

set -e

PRODUCT_IDENTIFIER=$(echo ${JBOSS_IMAGE_NAME} | awk -F'/' '{print $2}')
SOURCES_DIR=/tmp/artifacts/
unzip "$SOURCES_DIR/broker-plugin.zip" -d ${SOURCES_DIR}/broker-plugin

for jar in opt/broker-plugin/lib/amqp-connector.jar opt/broker-plugin/lib/sasl-delegation.jar opt/shutdown-hook/lib/shutdown-hook.jar
do
    LICENSE_DIR=/root/licenses/${PRODUCT_IDENTIFIER}/${jar}
    mkdir -p ${LICENSE_DIR}
    unzip -nj "$SOURCES_DIR/broker-plugin/${jar}" 'licenses/*' -d ${LICENSE_DIR}
done

