#!/bin/sh

set -e

PRODUCT_IDENTIFIER=$(echo ${JBOSS_IMAGE_NAME} | awk -F'/' '{print $2}')
LICENSE_DIR=/root/licenses/${PRODUCT_IDENTIFIER}
SOURCES_DIR=/tmp/artifacts/

unzip "$SOURCES_DIR/standard-controller.zip" -d ${SOURCES_DIR}/standard-controller

mkdir -p ${LICENSE_DIR}
unzip -nj "$SOURCES_DIR/standard-controller/standard-controller.jar" 'licenses/*' -d ${LICENSE_DIR}

