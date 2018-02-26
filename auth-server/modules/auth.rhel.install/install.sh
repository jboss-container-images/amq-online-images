#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

{
	mkdir -p ${KEYCLOAK_PLUGIN_DIR}/configuration
	mkdir -p ${KEYCLOAK_PLUGIN_DIR}/bin
	mkdir -p ${KEYCLOAK_PLUGIN_DIR}/providers
	mv ${ADDED_DIR}/configuration/* ${KEYCLOAK_PLUGIN_DIR}/configuration/
	mv ${ADDED_DIR}/sh/* ${KEYCLOAK_PLUGIN_DIR}/bin/
	mv ${SOURCES_DIR}/sasl-plugin.jar ${KEYCLOAK_PLUGIN_DIR}/providers/
}

