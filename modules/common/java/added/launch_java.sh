#!/bin/sh
set -x
JAR=$1
shift

source /usr/local/dynamic-resources/dynamic_resources.sh

JAVA_OPTS="$(/opt/run-java/java-default-options)"

LOG_LEVEL=${LOG_LEVEL:-info}

# Make sure that we use /dev/urandom
JAVA_OPTS="${JAVA_OPTS} -DLOG_LEVEL=${LOG_LEVEL} -Dvertx.disableDnsResolver=true -Dvertx.cacheDirBase=/tmp -Djava.security.egd=file:/dev/./urandom"

exec java $JAVA_OPTS -jar $JAR $JAVA_OPTS $@
