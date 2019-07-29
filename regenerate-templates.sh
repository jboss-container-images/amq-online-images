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
VERSION=1.2
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

set -o allexport
source ${DIR}/olm.amqonline.env
set +o allexport

pushd ${WORKDIR}
make -e \
    DOCKER_ORG=amq7 \
    DOCKER_ORG_PREVIEW=amq7-tech-preview \
    DOCKER_REGISTRY_PREFIX=registry.redhat.io/ \
    IMAGE_PULL_POLICY=Always \
    TAG=${VERSION} \
    VERSION=${VERSION} \
    templates
popd

echo Rsyncing into ${TARGET_TEMPLATE_DIR}

# if the OLM directory is named "amq-online"

if [ -d ${WORKDIR}/templates/build/enmasse-${VERSION}/install/olm/amq-online ]; then
	# we temporarily rename it to "enmasse" in order use the same workflow in the next steps
	mv ${WORKDIR}/templates/build/enmasse-${VERSION}/install/olm/amq-online ${WORKDIR}/templates/build/enmasse-${VERSION}/install/olm/enmasse
fi

rsync --exclude '*.orig' -a ${WORKDIR}/templates/build/enmasse-${VERSION}/* ${TARGET_TEMPLATE_DIR}
rm -rf templates/docs

# Ensure that we only have new files

## remove all old files
rm -Rf templates/install/olm/amq-online
## replace with new content
mv templates/install/olm/enmasse templates/install/olm/amq-online

# fix up new content
pushd templates/install/olm/amq-online
for i in $(ls *.yaml); do
	mv "$i" "amq-online-$i"
done
rm amq-online-enmasse.package.yaml
cat << ___EOF___ > amq-online.package.yaml
packageName: amq-online
channels:
- name: stable
  currentCSV: amqonline.${VERSION}.0
___EOF___

# fix up the CSV
mv amq-online-enmasse.clusterserviceversion.yaml amq-online.${VERSION}.0.clusterserviceversion.yaml

# done

popd
git add --all templates/install/olm/amq-online

exit 0
