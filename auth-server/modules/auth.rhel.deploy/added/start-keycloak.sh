#!/bin/bash
KEYSTORE_PATH=${JBOSS_HOME}/standalone/configuration/certificates.keystore
CERT_PATH=${JBOSS_HOME}/standalone/cert

if [ $KEYCLOAK_USER ] && [ $KEYCLOAK_PASSWORD ]; then
    /opt/eap/bin/add-user-keycloak.sh --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
fi

openssl pkcs12 -export -passout pass:enmasse -in ${CERT_PATH}/tls.crt -inkey ${CERT_PATH}/tls.key -name "server" -out /tmp/certificates-keystore.p12

keytool -importkeystore -srcstorepass enmasse -deststorepass enmasse -destkeystore ${KEYSTORE_PATH} -srckeystore /tmp/certificates-keystore.p12 -srcstoretype PKCS12

${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0 -c standalone.xml
