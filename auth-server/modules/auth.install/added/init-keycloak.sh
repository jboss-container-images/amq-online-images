#!/bin/sh
KEYCLOAK_DIR=$JBOSS_HOME
KEYCLOAK_CONFIG=${KEYCLOAK_DIR}/standalone/configuration/standalone.xml

java -jar /usr/share/java/saxon.jar -s:${KEYCLOAK_CONFIG} -xsl:${KEYCLOAK_DIR}/addSaslPlugin.xsl -o:${KEYCLOAK_CONFIG}
java -jar /usr/share/java/saxon.jar -s:${KEYCLOAK_CONFIG} -xsl:${KEYCLOAK_DIR}/removeFileLogging.xsl -o:${KEYCLOAK_CONFIG}
java -jar /usr/share/java/saxon.jar -s:${KEYCLOAK_CONFIG} -xsl:${KEYCLOAK_DIR}/addKeyStore.xsl -o:${KEYCLOAK_CONFIG}

chown -R jboss:root ${KEYCLOAK_DIR}
find ${KEYCLOAK_DIR} -type d -exec chmod 770 {} \;
find ${KEYCLOAK_DIR}/standalone/configuration -type f -exec chmod 660 {} \;

