#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

{
	mkdir -p /etc/qpid-dispatch/
	mv ${ADDED_DIR}/* /etc/qpid-dispatch/
}

chown -R 185:0 /etc/qpid-dispatch/

