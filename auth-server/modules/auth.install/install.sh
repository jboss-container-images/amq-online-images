#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=keycloak-bin


# unpack
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tar.gz" -C $JBOSS_HOME
}

$JBOSS_HOME/bin/init-keycloak.sh

