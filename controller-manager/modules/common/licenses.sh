#!/bin/sh

set -e

PRODUCT_IDENTIFIER=$(echo ${JBOSS_IMAGE_NAME} | awk -F'/' '{print $2}')
LICENSE_DIR=/root/licenses/${PRODUCT_IDENTIFIER}
SOURCES_DIR=/tmp/artifacts/

unzip "$SOURCES_DIR/enmasse-controller-manager.zip" -d ${SOURCES_DIR}/enmasse-controller-manager

mkdir -p ${LICENSE_DIR}
#unzip -nj "$SOURCES_DIR/enmasse-controller-manager.zip" 'licenses/*' -d ${LICENSE_DIR}
