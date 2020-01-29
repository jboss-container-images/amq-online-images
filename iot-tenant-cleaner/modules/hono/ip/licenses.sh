#!/usr/bin/env bash

set -e

PRODUCT_IDENTIFIER=$(echo ${JBOSS_IMAGE_NAME} | awk -F'/' '{print $2}')
LICENSE_DIR=/root/licenses/${PRODUCT_IDENTIFIER}
SOURCES_DIR=/tmp/artifacts/
TMP=/tmp

mkdir -p "${LICENSE_DIR}"
unzip -nj "${SOURCES_DIR}/iot-tenant-cleaner.jar" 'licenses/*' -d ${LICENSE_DIR}
