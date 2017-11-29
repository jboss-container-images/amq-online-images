#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=keycloak-bin


# unpack
{
	echo 
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tar.gz" -C $JBOSS_HOME
}
ls -lR $JBOSS_HOME

$JBOSS_HOME/bin/init-keycloak.sh

