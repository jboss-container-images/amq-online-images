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
DOCKER_ORG=amq7
VERSION=1.1
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
    DOCKER_ORG=amq7 \
    DOCKER_ORG_PREVIEW=amq7-tech-preview \
    DOCKER_REGISTRY_PREFIX=registry.redhat.io/ \
    IMAGE_PULL_POLICY=Always \
    TAG=${VERSION} \
    templates
popd

echo Rsyncing into ${TARGET_TEMPLATE_DIR}

rsync --exclude '*.orig' -a ${WORKDIR}/templates/build/enmasse-${VERSION}/* ${TARGET_TEMPLATE_DIR}

rm -rf templates/docs

if [[ ${KEEP_WORK_DIR} -eq 0 ]]; then
    rm -rf ${WORKDIR}
else
    echo Retained working directory: ${WORKDIR}
fi

exit 0
