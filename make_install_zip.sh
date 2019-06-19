#!/usr/bin/env bash
# Makes the amq-online-install zip

TAG=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


if [ ! "${TAG}" ] 
then
   1>&2 echo "Usage: $0 <tag>"
   exit 1
fi

mkdir -p ${DIR}/target
TARGET_ZIP=$DIR/target/amq-online-install-${TAG}.zip

(cd templates; zip -qr ${TARGET_ZIP} .)


exit 0
