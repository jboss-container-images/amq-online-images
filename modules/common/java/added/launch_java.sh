#!/bin/sh
set -x
JAR=$1
shift

. /bin/dynamic_resources.sh

MAX_HEAP=`get_heap_size`
if [ -n "$MAX_HEAP" ]; then
  JAVA_OPTS="-Xms${MAX_HEAP}m -Xmx${MAX_HEAP}m $JAVA_OPTS"
fi

# Make sure that we use /dev/urandom
JAVA_OPTS="${JAVA_OPTS} -Dvertx.cacheDirBase=/tmp -Djava.security.egd=file:/dev/./urandom"

exec java $JAVA_OPTS -jar $JAR $JAVA_OPTS $@