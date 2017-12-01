#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

mv ${ADDED_DIR}/start-keycloak.sh $JBOSS_HOME/bin
chmod -R ug+x $JBOSS_HOME/bin/start-keycloak.sh
chown jboss:0 $JBOSS_HOME/bin/start-keycloak.sh

cat $JBOSS_HOME/bin/start-keycloak.sh
mv ${JBOSS_HOME}/providers/sasl-plugin*.jar ${JBOSS_HOME}/standalone/deployments/sasl-plugin.jar
