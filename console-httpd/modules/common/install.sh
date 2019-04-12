#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
SCRIPT_DIR=$(dirname $0)

# unpack
{
    unzip -o "${SOURCES_DIR}/console-httpd-dist.zip"
}
