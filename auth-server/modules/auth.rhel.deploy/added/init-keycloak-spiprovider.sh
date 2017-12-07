#!/bin/sh
KEYCLOAK_CONFIG=${JBOSS_HOME}/standalone/configuration/standalone.xml

xsltproc ${JBOSS_HOME}/addSpiProvider.xsl ${KEYCLOAK_CONFIG} > ${KEYCLOAK_CONFIG}.new; mv ${KEYCLOAK_CONFIG}.new ${KEYCLOAK_CONFIG}
