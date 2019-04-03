#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added
PRODUCT_IDENTIFIER=$(echo ${JBOSS_IMAGE_NAME} | awk -F'/' '{print $2}')
LICENSE_DIR=/root/licenses/${PRODUCT_IDENTIFIER}

mkdir -p ${LICENSE_DIR}
mv ${ADDED_DIR}/licenses/* ${LICENSE_DIR}/
