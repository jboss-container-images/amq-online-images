#!/bin/sh

set -e

SCRIPT_DIR=$(dirname $0)
ADDED_DIR=${SCRIPT_DIR}/added

mv ${ADDED_DIR}/start-keycloak.sh $JBOSS_HOME/bin
mv ${ADDED_DIR}/addSpiProvider.xsl $JBOSS_HOME

chmod -R ug+x $JBOSS_HOME/bin/start-keycloak.sh
chown jboss:0 $JBOSS_HOME/bin/start-keycloak.sh

KEYCLOAK_CONFIG=${JBOSS_HOME}/standalone/configuration/standalone.xml
java -jar /usr/share/java/saxon.jar -s:${KEYCLOAK_CONFIG} -xsl:${JBOSS_HOME}/addSpiProvider.xsl -o:${KEYCLOAK_CONFIG}

