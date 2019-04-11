#!/usr/bin/env bash

set -ex
JAR="$1"
shift

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ "${JAVA_DEBUG}" = "true" ]]; then
  java_debug_args="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=${JAVA_DEBUG_PORT:-8787}"
fi

if [[ "${DISABLE_DEFAULT_OPTS}" != "true" ]]; then
	JAVA_DEFAULT_OPTS="$(${SCRIPTDIR}/java-default-options)"
fi

if [[ "${DISABLE_APP_OPTS}" == "true" ]]; then
	JAVA_APP_OPTS=""
fi

export MALLOC_ARENA_MAX=2
exec java ${JAVA_DEFAULT_OPTS} ${JAVA_APP_OPTS} ${JAVA_OPTS} ${java_debug_args} -jar ${JAR} $@
