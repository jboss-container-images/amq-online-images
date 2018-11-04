#!/bin/sh

set -e

PRODUCT_IDENTIFIER=$(echo ${JBOSS_IMAGE_NAME} | awk -F'/' '{print $2}')
SOURCES_DIR=/tmp/artifacts/

for jar in amqp-connector sasl-delegation jmx-exporter
do
    LICENSE_DIR=/root/licenses/${PRODUCT_IDENTIFIER}/${jar}
    mkdir -p ${LICENSE_DIR}
    unzip -nj "$SOURCES_DIR/${jar}.jar" 'licenses/*' -d ${LICENSE_DIR}
done

