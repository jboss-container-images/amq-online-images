#!/usr/bin/env bash

function print {
    cat <<EOF>>$XMLFILE
    <dependency>
        <packageName>$1</packageName>
        <version>$2</version>
        <licenses>
            <license>
                <name>$3</name>
                <url>./$4</url>
            </license>
        </licenses>
    </dependency>
EOF
}

do_usage_and_exit () {
    1>&2 echo "$0: Usage $0 [-keep-work-dir] [--tag <tag>] <repo>"
    exit 0;

}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DOCKER_ORG=amq7
VERSION=dev
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

TARGET_LICENSE_DIR="${DIR}/modules/common/go/added/licenses"
if [[ ! -d "${TARGET_LICENSE_DIR}" ]]; then
    1>&2 echo "$0: Target license directory ${TARGET_LICENSE_DIR} does not exist."
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

if [[ $rc != 0 ]]; then
    1>&2 echo "$0: Git clone failed."
    exit $rc
fi

pushd ${WORKDIR}
VENDORLIST=${WORKDIR}/vendor-list.txt
XMLFILE=$WORKDIR/licenses.xml
HTMLFILE=$WORKDIR/licenses.html
XSLFILE=$WORKDIR/licenses.xsl
LISTFILE=$WORKDIR/licenses.txt
ARCHIVE=$WORKDIR/licenses.tgz

retrodep . > ${VENDORLIST}

cat <<EOF>>$XMLFILE
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<licenseSummary>
  <dependencies>
EOF

pushd ${WORKDIR}/vendor
for m in $(awk '{print $2}' ${VENDORLIST}); do
    f=$(echo $m | awk -F ':' '{print $1}')
    v=$(echo $m | awk -F ':' '{print $2}')
    l=$(find "$f" -iname 'license*')
    if [[ -z "$l" ]]; then
        l=$(find "$f" -iname 'readme*')
    fi
    if [[ "$l" ]]; then
        i=$(identify_license $l 2> /dev/null)
        if [[ -z $i ]]; then
            echo "$f Unrecognised $l"
            print $f $v Unrecognised $l
        else
            n=$(echo $i | awk '{print $2}')
            print $f $v $n $l
        fi
        echo $l >> $LISTFILE
    else
        echo "$f Unknown"
        print $f $v Unknown
    fi
done
tar -zcf $ARCHIVE ${WORKDIR}/LICENSE $(cat $LISTFILE)

popd
cat <<EOF>>$XMLFILE
  </dependencies>
</licenseSummary>
EOF

xsltproc ${XSLFILE} ${XMLFILE} > ${HTMLFILE}

cp ${XMLFILE} ${LISTFILE} ${ARCHIVE} ${HTMLFILE} ${TARGET_LICENSE_DIR}/

if [[ ${KEEP_WORK_DIR} -eq 0 ]]; then
    rm -rf ${WORKDIR}
else
    echo Retained working directory: ${WORKDIR}
fi

exit 0
