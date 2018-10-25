#!/bin/sh


BROKER_DIR=/opt/amq
sed -i '$ d' ${BROKER_DIR}/bin/launch.sh
source /opt/amq/bin/launch.sh

BROKER_CUSTOM_DIR=${BROKER_DIR}/custom

source $BROKER_CUSTOM_DIR/bin/env.sh
CONFIG_TEMPLATES=${BROKER_CUSTOM_DIR}/conf

echo "JAVA_OPTS=$JAVA_OPTS"

# Parameters are
# - instance directory
function init_configure() {
    local instanceDir=$1

    cp -n $BROKER_CUSTOM_DIR/lib/* $BROKER_DIR/lib/
    cp -n $BROKER_CUSTOM_DIR/conf/* $BROKER_DIR/conf/
}

function update_ssl_certs() {
    local instanceDir=$1
    rm -rf ${TRUSTSTORE_PATH} ${KEYSTORE_PATH} ${AUTH_TRUSTSTORE_PATH} ${EXTERNAL_KEYSTORE_PATH}
    cp -n $BROKER_CUSTOM_DIR/certs/* $instanceDir/etc/
    echo "cp -n $BROKER_CUSTOM_DIR/certs/* $instanceDir/etc/"
}


# This needs to be at the toplevel outside any functions
# For the standard address space, the shutdown hooks need time to run before broker is shut down
if [ "$ADDRESS_SPACE_TYPE" != "brokered" ]; then
    trap "" TERM INT
fi

function startServer() {

  instanceDir="${HOME}/${AMQ_NAME}"
  echo "Configuring the Broker $instanceDir"

  init_configure $instanceDir
  configure $instanceDir

  update_ssl_certs $instanceDir
  exec ${instanceDir}/bin/artemis run
}

startServer $1