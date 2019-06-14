#!/usr/bin/env bash
CONTAINER=broker
EXPECTED_VERSION=2.6.3
TARGET_DIR=/var/run/artemis/split-1/broker/
SOURCE_DIR=/home/jboss/broker/data/

cat << EOF

Remediation for https://issues.jboss.org/browse/ENTMQMAAS-1170

This script will copy the current Artemis journal for broker pods running in this AMQ Online 1.0/1.1.0
infra namespace to the correct persistent location.  It should be run before upgrade to AMQ Online 1.1.1.

It is important that applications using the AMQ Online are shutdown (or quiesced) before you proceed so that
there is no messaging traffic through the system.
EOF
read -p "Are you sure? " -n 1 -r
echo
if [[ ! ${REPLY} =~ ^[Yy]$ ]]
then
    echo Aborted.
    exit 1
fi

for p in $(oc get pod --selector=role=broker -o go-template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
do
   echo
   echo =========
   echo Processing broker pod ${p}
   SERVER_JAR=`oc exec -c ${CONTAINER} ${p} -- find /opt/amq/lib/ -name "artemis-server-*.jar"`
   VERSION=$(oc exec -c ${CONTAINER} ${p} -- unzip -c $SERVER_JAR META-INF/maven/org.apache.activemq/artemis-server/pom.properties | grep version | sed -e 's/^.*\([0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\).*$/\1/')
   echo Detected Artemis version ${VERSION}
   if [ "${VERSION}" != "${EXPECTED_VERSION}" ] 
   then
       echo Skipping broker pod ${p}, found Artmeis version ${VERSION} expecting ${EXPECTED_VERSION}
       continue
   fi
   oc exec -c ${CONTAINER} ${p} -- test -d ${TARGET_DIR} 2>/dev/null
   TARGET_DIR_EXIST=$?
   if [ ${TARGET_DIR_EXIST} -eq 0 ] 
   then 
       echo Skipping broker pod ${p}, target data directory already exists in pod at location ${TARGET_DIR}
       continue
   fi 

   oc exec -c ${CONTAINER} ${p} -- test -d ${SOURCE_DIR} 2>/dev/null
   SOURCE_DIR_EXIST=$?
   if [ ${SOURCE_DIR_EXIST} -ne 0 ] 
   then 
       echo Skipping broker pod ${p}, source data directory does not exist in pod at location ${SOURCE_DIR}
       continue
   fi 

   oc exec -c ${CONTAINER} ${p} -- mkdir -p ${TARGET_DIR}
   MKDIR_TARGET=$?
   if [ ${MKDIR_TARGET} -ne 0 ] 
   then
       echo Skipping broker pod ${p}, target data directory ${TARGET_DIR} cannot be created.
       continue
   fi 

   oc exec -c ${CONTAINER} ${p} -- cp -r ${SOURCE_DIR} ${TARGET_DIR}
   echo Successfully processed broker pod ${p}

done

echo "All broker pods processed"




