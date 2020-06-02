#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/

mv "$SOURCES_DIR/iot-device-connection-infinispan.jar" /opt
mv "$SOURCES_DIR/iot-device-registry-infinispan.jar" /opt
mv "$SOURCES_DIR/iot-device-registry-jdbc.jar" /opt
