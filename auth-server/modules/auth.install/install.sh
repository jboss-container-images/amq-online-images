#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/

DISTRO_NAME=keycloak-bin

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added


# unpack
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tar.gz" -C $JBOSS_HOME
	mv ${ADDED_DIR}/addSaslPlugin.xsl $JBOSS_HOME
	mv ${ADDED_DIR}/removeFileLogging.xsl $JBOSS_HOME
	mv ${ADDED_DIR}/addKeyStore.xsl $JBOSS_HOME
	chown jboss:0 $JBOSS_HOME/addKeyStore.xsl
	chown jboss:0 $JBOSS_HOME/addSaslPlugin.xsl
	chown jboss:0 $JBOSS_HOME/removeFileLogging.xsl
}
chmod ug+x ${ADDED_DIR}/init-keycloak.sh
${ADDED_DIR}/init-keycloak.sh

