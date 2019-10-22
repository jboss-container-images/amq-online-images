#!/usr/bin/env bash

URL=`cat ${CEKIT_LOG} | egrep -e "${OSBS_URL}/brew/taskinfo\?taskID=[0-9]*" -o -m 1`;

if [ -z "${URL}" ] ; then
	echo "No taskinfo for ${pwd}";
    exit 1;
fi

IMAGE=`wget -q  --no-cache -O - ${URL} 2>/dev/null | grep "repositories = " | sed -e "s/.*repositories = \([^ ]*\)<br.*/\1/" `;

while [ -z "$IMAGE" ] ; do
	echo "Waiting for scratch job to complete .... ${URL}";
	sleep 30s;
	IMAGE=`wget -q  --no-cache -O - ${URL} 2>/dev/null | grep "repositories = " | sed -e "s/.*repositories = \([^ ]*\)<br.*/\1/" `;
done

echo "Retrieving ${IMAGE} ...";
${DOCKER} pull ${IMAGE};
echo "Tagging & pushing ${DOCKER_IMAGE} ...";
${DOCKER} tag ${IMAGE} ${DOCKER_IMAGE};
bash ../scripts/retry.sh "${DOCKER} push ${DOCKER_IMAGE}" 10 10;
