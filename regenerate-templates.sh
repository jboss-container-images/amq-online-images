#!/usr/bin/env bash

do_patch () {
    PATCH_DIR=$1
    PATCH_TARGET=$2
    if [ -d "${PATCH_DIR}" ]
    then
        for patch in $(find ${PATCH_DIR} -type f -name "*.patch" | sort -g); do
            echo Applying patch ${patch}
            patch --remove-empty-files --merge -f -d "${PATCH_TARGET}" -p1 < $patch
            if [[ $rc != 0 ]]; then
                1>&2 echo "$0: Patch ${patch} failed."
                exit $rc
            fi
        done;
    fi
}

do_usage_and_exit () {
    1>&2 echo "$0: Usage $0 [-keep-work-dir] [--tag <tag>] <repo>"
    exit 0;

}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DOCKER_ORG=rh-amqmaas-1-tech-preview
VERSION=1.0
KEEP_WORK_DIR=0


declare -a POS
while [[ $# -gt 0 ]]
do
    case "$1" in
        --keep-work-dir)
        KEEP_WORK_DIR=1
        shift
        ;;
        --tag)
        TAG=$2
        shift 2
        ;;
        --help)
        do_usage_and_exit
        ;;
        *)
        POS+=("$1")
        shift
        ;;
    esac
done
set -- "${POS[@]}" 

REPO=${1}

if [[ -z "${REPO}" ]]; then 
    do_usage_and_exit
fi

TARGET_TEMPLATE_DIR="${DIR}/templates"
if [[ ! -d "${TARGET_TEMPLATE_DIR}" ]]; then
    1>&2 echo "$0: Target templates directory ${TARGET_TEMPLATE_DIR} does not exist."
    exit 1
fi

WORKDIR=$(mktemp -d)

declare -a GITARGS

GITARGS+=("--depth")
GITARGS+=("1")
if [[ ! -z "${TAG}" ]]; then
    GITARGS+=("--branch")
    GITARGS+=("${TAG}")
fi
GITARGS+=("--")
GITARGS+=("${REPO}")
GITARGS+=("${WORKDIR}")

echo Shallow cloning ${REPO} ${TAG}
git clone ${GITARGS[*]}
rc=$?

if [[ $rc != 0 ]]; then
    1>&2 echo "$0: Git clone failed."
    exit $rc
fi

if [[ -d "${DIR}/patches" ]]; then
    echo Applying patches
    do_patch "${DIR}/patches" "${WORKDIR}"
else
    echo No patches to apply
fi


pushd ${WORKDIR}
make \
    DOCKER_ORG=${DOCKER_ORG} \
    DOCKER_REGISTRY_PREFIX="" \
    ADDRESS_SPACE_CONTROLLER_IMAGE=${DOCKER_ORG}/amqmaas10-address-space-controller-openshift:${VERSION} \
    API_SERVER_IMAGE=${DOCKER_ORG}/amqmaas10-api-server-openshift:${VERSION} \
    STANDARD_CONTROLLER_IMAGE=${DOCKER_ORG}/amqmaas10-standard-controller-openshift:${VERSION} \
    ROUTER_IMAGE=amq-interconnect/amq-interconnect-1.2-openshift:1.0 \
    ARTEMIS_IMAGE=amq-broker-7/amq-broker-72-openshift:1.1 \
    TOPIC_FORWARDER_IMAGE=${DOCKER_ORG}/amqmaas10-topic-forwarder-openshift:${VERSION} \
    AGENT_IMAGE=${DOCKER_ORG}/amqmaas10-agent-openshift:${VERSION} \
    BROKER_PLUGIN_IMAGE=${DOCKER_ORG}/amqmaas10-broker-openshift:${VERSION} \
    MQTT_GATEWAY_IMAGE=${DOCKER_ORG}/amqmaas10-mqtt-gateway-openshift:${VERSION} \
    MQTT_LWT_IMAGE=${DOCKER_ORG}/amqmaas10-mqtt-lwt-openshift:${VERSION} \
    NONE_AUTHSERVICE_IMAGE=${DOCKER_ORG}/amqmaas10-none-auth-openshift:${VERSION} \
    KEYCLOAK_IMAGE=redhat-sso-7/sso72-openshift:1.1 \
    KEYCLOAK_PLUGIN_IMAGE=${DOCKER_ORG}/amqmaas10-auth-plugin-openshift:${VERSION} \
    KEYCLOAK_CONTROLLER_IMAGE=${DOCKER_ORG}/amqmaas10-auth-controller-openshift:${VERSION} \
    SERVICE_BROKER_IMAGE=${DOCKER_ORG}/amqmaas10-service-broker-openshift:${VERSION} \
    templates
mvn clean install -DskipTests -T 2C
popd

echo Rsyncing into ${TARGET_TEMPLATE_DIR}

rsync --exclude '*.orig' -a ${WORKDIR}/templates/build/enmasse-latest/* ${TARGET_TEMPLATE_DIR}

ADDRESS_SPACE_CONTROLLER_RESOURCES=$DIR/address-space-controller/modules/common/added
mkdir -p ${ADDRESS_SPACE_CONTROLLER_RESOURCES}
rsync -a ${WORKDIR}/address-space-controller/target/classes/addressplans ${ADDRESS_SPACE_CONTROLLER_RESOURCES}
rsync -a ${WORKDIR}/address-space-controller/target/classes/addressspaceplans ${ADDRESS_SPACE_CONTROLLER_RESOURCES}
rsync -a ${WORKDIR}/address-space-controller/target/classes/brokeredinfraconfigs ${ADDRESS_SPACE_CONTROLLER_RESOURCES}
rsync -a ${WORKDIR}/address-space-controller/target/classes/standardinfraconfigs ${ADDRESS_SPACE_CONTROLLER_RESOURCES}

rm -rf templates/docs

if [[ ${KEEP_WORK_DIR} -eq 0 ]]; then
    rm -rf ${WORKDIR}
else
    echo Retained working directory: ${WORKDIR}
fi

exit 0
