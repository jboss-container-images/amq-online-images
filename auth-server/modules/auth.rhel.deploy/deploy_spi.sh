#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

mv ${ADDED_DIR}/start-keycloak.sh $JBOSS_HOME/bin
mv ${ADDED_DIR}/addSpiProvider.xsl $JBOSS_HOME
chown jboss:0 $JBOSS_HOME/addSpiProvider.xsl

chmod ug+x ${ADDED_DIR}/init-keycloak-spiprovider.sh
${ADDED_DIR}/init-keycloak-spiprovider.sh
chmod -R ug+x $JBOSS_HOME/bin/start-keycloak.sh
chown jboss:0 $JBOSS_HOME/bin/start-keycloak.sh
