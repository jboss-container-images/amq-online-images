#!/usr/bin/env bash

set -e

SOURCES_DIR=/tmp/artifacts/

mv "$SOURCES_DIR/iot-http-adapter.jar" /opt
mv "$SOURCES_DIR/iot-lorawan-adapter.jar" /opt
mv "$SOURCES_DIR/iot-mqtt-adapter.jar" /opt
mv "$SOURCES_DIR/iot-sigfox-adapter.jar" /opt
