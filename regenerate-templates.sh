#!/bin/sh
ENMASSE_DIR=${1:-$PWD}
pushd $ENMASSE_DIR
DOCKER_ORG=rh-amqmaas-1
VERSION=dev
make DOCKER_ORG=rh-amqmaas-1 \
    DOCKER_REGISTRY_PREFIX="" \
    ADDRESS_SPACE_CONTROLLER_IMAGE=${DOCKER_ORG}/amqmaas10-address-space-controller-openshift:${VERSION} \
    API_SERVER_IMAGE=${DOCKER_ORG}/amqmaas10-api-server-openshift:${VERSION} \
    STANDARD_CONTROLLER_IMAGE=${DOCKER_ORG}/amqmaas10-standard-controller-openshift:${VERSION} \
    ROUTER_IMAGE=${DOCKER_ORG}/amqmaas10-router-openshift:${VERSION} \
    ARTEMIS_IMAGE=${DOCKER_ORG}/amqmaas10-broker-openshift:${VERSION} \
    TOPIC_FORWARDER_IMAGE=${DOCKER_ORG}/amqmaas10-topic-forwarder-openshift:${VERSION} \
    AGENT_IMAGE=${DOCKER_ORG}/amqmaas10-agent-openshift:${VERSION} \
    MQTT_GATEWAY_IMAGE=${DOCKER_ORG}/amqmaas10-mqtt-gateway-openshift:${VERSION} \
    MQTT_LWT_IMAGE=${DOCKER_ORG}/amqmaas10-mqtt-lwt-openshift:${VERSION} \
    NONE_AUTHSERVICE_IMAGE=${DOCKER_ORG}/amqmaas10-none-auth-openshift:${VERSION} \
    KEYCLOAK_IMAGE=redhat-sso-7/sso72-openshift:1.1 \
    KEYCLOAK_PLUGIN_IMAGE=${DOCKER_ORG}/amqmaas10-auth-plugin-openshift:${VERSION} \
    KEYCLOAK_CONTROLLER_IMAGE=${DOCKER_ORG}/amqmaas10-auth-controller-openshift:${VERSION} \
    SERVICE_BROKER_IMAGE=${DOCKER_ORG}/amqmaas10-service-broker-openshift:${VERSION} templates
popd
