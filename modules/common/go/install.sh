#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/

# unpack
mkdir -p /opt/
unzip "${SOURCES_DIR}/dist-bin.zip" -d /opt
