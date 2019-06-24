#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/

install -m 0755 -d /manifests
cd /manifests
tar xzvf ${SOURCES_DIR}/manifests.tar.gz
