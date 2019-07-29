#!/usr/bin/env bash

set -e

SCRIPT_DIR=$(dirname $0)
ANCESTOR_MANIFESTS_DIR=${SCRIPT_DIR}/ancestor_manifests

SOURCES_DIR=/tmp/artifacts/

install -m 0755 -d /manifests
cd /manifests

tar xzvf ${SOURCES_DIR}/olm_package.tar.gz
tar xzvf ${SOURCES_DIR}/olm_manifest.tar.gz
cp -r ${ANCESTOR_MANIFESTS_DIR}/* /manifests

