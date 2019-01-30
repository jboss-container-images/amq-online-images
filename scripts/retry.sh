#!/usr/bin/env bash

case "$OSTYPE" in
  darwin*)  READLINK=greadlink;; 
  *)        READLINK=readlink;;
esac

curdir="$(dirname $(${READLINK} -f ${0}))"

source "${curdir}/logger.sh"

EVAL="${1}"
RETRY=${2:-10} #repeat RETRY-times
WAIT=${3:-10} #with WAIT seconds of sleep

info "running command ${EVAL} with retry mechanism"
while (( RETRY > 0 )); do
    (( RETRY-- ))
    if ${EVAL}; then
        info "command completed successfully"
        exit 0
    fi
    info "remaining retry operations: ${RETRY}"
    sleep ${WAIT}
done
err_and_exit "command ${EVAL} failed"
