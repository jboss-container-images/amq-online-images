#!/usr/bin/env bash
# Makes the amq-online-install zip

set -e

TAG=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


if [ ! "${TAG}" ] 
then
   1>&2 echo "Usage: $0 <tag>"
   exit 1
fi

TARGET_DIR=${DIR}/target
mkdir -p ${TARGET_DIR}
TARGET_ZIP=${TARGET_DIR}/amq-online-install-${TAG}.zip

(cd ${DIR}/templates; zip -qr ${TARGET_ZIP} .)

exit 0
