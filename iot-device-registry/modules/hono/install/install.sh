#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/
TARGET_DIR="/"

mv "$SOURCES_DIR/iot-device-connection-infinispan.jar" "$TARGET_DIR"
mv "$SOURCES_DIR/iot-device-registry-infinispan.jar" "$TARGET_DIR"
mv "$SOURCES_DIR/iot-device-registry-jdbc.jar" "$TARGET_DIR"
