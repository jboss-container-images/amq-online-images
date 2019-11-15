#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/

# unpack
unzip ${SOURCES_DIR}/olm-manifest -dist.zip -d /
