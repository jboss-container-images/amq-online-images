#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)

DISTRO_NAME=console-init

# unpack
{
    unzip "${SOURCES_DIR}/console-init-dist.zip"
}
