#!/bin/bash

SUBDIR_START_LINE=`grep -n -m 1 "$(pwd)" ${CEKIT_OUTPUT_FILE} | cut -f1 -d: `;
TOTAL_LINES=`wc -l ${CEKIT_OUTPUT_FILE} | cut -f1 -d ' '`;
LINE_TO_TAIL=`expr ${TOTAL_LINES} - ${SUBDIR_START_LINE}`;
URL=`tail -${LINE_TO_TAIL} ${CEKIT_OUTPUT_FILE} | egrep -e "${OSBS_URL}/brew/taskinfo\?taskID=[0-9]*" -o -m 1`;

if [ -z "${URL}" ] ; then
	echo "No taskinfo for $(pwd)";
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
