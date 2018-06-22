#!/bin/sh
ENMASSE_DIR=${1}
pushd $ENMASSE_DIR/templates
make DOCKER_ORG=rh-amqmaas-1 \
    DOCKER_REGISTRY=""
    ADDRESS_SPACE_CONTROLLER_IMAGE=amqmaas10-address-space-controller-openshift \
    API_SERVER_IMAGE=amqmaas10-api-server-openshift \
    STANDARD_CONTROLLER_IMAGE=amqmaas10-standard-controller-openshift \
    ROUTER_IMAGE=amqmaas10-router-openshift \
    ARTEMIS_IMAGE=amqmaas10-broker-openshift \
    TOPIC_FORWARDER_IMAGE=amqmaas10-topic-forwarder-openshift \
    ROUTER_METRICS_IMAGE=amqmaas10-router-metrics-openshift \
    AGENT_IMAGE=amqmaas10-agent-openshift \
    MQTT_GATEWAY_IMAGE=amqmaas10-mqtt-gateway-openshift \
    MQTT_LWT_IMAGE=amqmaas10-mqtt-lwt-openshift \
    NONE_AUTHSERVICE_IMAGE=amqmaas10-none-auth-openshift \
    KEYCLOAK_IMAGE=redhat-sso-7/sso72-openshift:1.1 \
    KEYCLOAK_PLUGIN_IMAGE=amqmaas10-auth-plugin-openshift \
    KEYCLOAK_CONTROLLER_IMAGE=amqmaas10-auth-controller-openshift \
    SERVICE_BROKER_IMAGE=amqmaas10-service-broker-openshift
