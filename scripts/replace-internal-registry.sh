#!/bin/bash
REGISTRY=$1
find templates -name "*.yaml" | xargs sed -e "s,registry.redhat.io/amq7/amq-online-,${REGISTRY}/rh-osbs/amq7-amq-online-,g" -i
find templates -name "*.yaml" | xargs sed -e "s,registry.redhat.io/amq7-tech-preview/amq-online-,${REGISTRY}/rh-osbs/amq7-tech-preview-amq-online-,g" -i
