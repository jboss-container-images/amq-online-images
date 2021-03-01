#!/usr/bin/env bash

set -e

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

cleanup () {
    if [[ ${KEEP_WORK_DIR} -eq 0 ]]; then
        echo "Cleaning work directory: ${WORKDIR}"
        rm -rf ${WORKDIR}
    else
        echo Retained working directory: ${WORKDIR}
    fi
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DOCKER_ORG=amq7
VERSION=1.7
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
TARGET_TEMPLATE_DEFAULT_DIR="${DIR}/templates/default"
TARGET_TEMPLATE_OCP311_DIR="${DIR}/templates/ocp311"

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

trap 'rm -Rf "$WORKDIR"' EXIT

echo Shallow cloning ${REPO} ${TAG}
git clone ${GITARGS[*]}
rc=$?

# cleanup when exiting
trap 'cleanup' EXIT

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
make -e \
    SKIP_MANIFESTS=true \
    DOCKER_REGISTRY_PREFIX=registry.redhat.io/amq7/ \
    IMAGE_PULL_POLICY=Always \
    VERSION=${VERSION} \
    TAG=${VERSION} \
    templates
popd

echo Rsyncing into ${TARGET_TEMPLATE_DIR}

mkdir -p ${TARGET_TEMPLATE_DEFAULT_DIR} ${TARGET_TEMPLATE_OCP311_DIR}

rsync --exclude '*.orig' -a ${WORKDIR}/templates/build/default/enmasse-${VERSION}/* ${TARGET_TEMPLATE_DEFAULT_DIR}
rsync --exclude '*.orig' -a ${WORKDIR}/templates/build/prekube1_16/enmasse-${VERSION}/* ${TARGET_TEMPLATE_OCP311_DIR}
rm -rf templates/docs

exit 0
