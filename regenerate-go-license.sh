#!/usr/bin/env bash

set -e

function print {
    cat <<EOF>>$XMLFILE
    <dependency>
        <packageName>$1</packageName>
        <version>$2</version>
        <licenses>
            <license>
                <name>$3</name>
                <url>$4</url>
            </license>
        </licenses>
    </dependency>
EOF
}


function get_version() {
    module=$1

    while true
    do
        version=$(GO111MODULE=on go list -m "${module}" 2>/dev/null| awk '{print $2}')
        if [[ -z ${version} ]]; then
	    module=$(echo "${module}" | awk  '@include "join"; {split($1,parts,"/"); if (length(parts) > 1) print join(parts,1,length(parts)-1,"/")}')
            if [[ -z ${module} ]]; then
                echo Unknown
                return
            fi 
        else
            echo "$version"
            return
	fi
    done
}

do_usage_and_exit () {
    1>&2 echo "$0: Usage $0 [--keep-work-dir] [--tag <tag>] <repo>"
    exit 0;

}

clean() {
    rm -rf ${1}
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

if [[ ${KEEP_WORK_DIR} -eq 0 ]]; then
    trap clean EXIT
fi

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
XSLFILE=$WORKDIR/scripts/licenses.xsl
LISTFILE=$WORKDIR/licenses.txt
ARCHIVE=$WORKDIR/licenses.tgz


go-licenses csv ./pkg/...  2>/dev/null > ${VENDORLIST}

touch ${LISTFILE}

cat <<EOF>>$XMLFILE
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<licenseSummary>
  <dependencies>
EOF

#github.com/prometheus/client_model/go,https://github.com/prometheus/client_model/blob/master/go/LICENSE,Apache-2.0
pushd ${WORKDIR}/vendor
while IFS= read -r line ; do
    module=$(echo $line | awk -F ',' '{print $1}')
    licenseurl=$(echo $line | awk -F ',' '{print $2}')
    licensename=$(echo $line | awk -F ',' '{print $3}')
    version=$(get_version "${module}")

    if [[ -d "${module}" ]]; then
        licensefile=$(find "${module}" -iname 'license*')
        if [[ -z "$licensefile" ]]; then
            licensefile=$(find "${module}" -iname 'readme*')
        fi
        if [[ "$licensefile" ]]; then
            echo $licensefile >> $LISTFILE
        fi
    fi


    print ${module} ${version} ${licensename} ${licenseurl}
done < ${VENDORLIST}
tar -zcf $ARCHIVE ${WORKDIR}/LICENSE $(cat $LISTFILE)

popd
cat <<EOF>>$XMLFILE
  </dependencies>
</licenseSummary>
EOF

xsltproc ${XSLFILE} ${XMLFILE} > ${HTMLFILE}

cp ${XMLFILE} ${LISTFILE} ${ARCHIVE} ${HTMLFILE} ${TARGET_LICENSE_DIR}/


exit 0
