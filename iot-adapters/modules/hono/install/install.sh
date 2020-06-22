#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/
TARGET_DIR=/

mv "$SOURCES_DIR/iot-http-adapter.jar" "$TARGET_DIR"
mv "$SOURCES_DIR/iot-lorawan-adapter.jar" "$TARGET_DIR"
mv "$SOURCES_DIR/iot-mqtt-adapter.jar" "$TARGET_DIR"
mv "$SOURCES_DIR/iot-sigfox-adapter.jar" "$TARGET_DIR"
