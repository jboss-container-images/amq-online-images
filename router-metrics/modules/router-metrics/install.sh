#!/bin/sh

set -e

SOURCES_DIR=/tmp/artifacts/
DISTRO_NAME=router-metrics
# unpack
{
	tar xzf "${SOURCES_DIR}/$DISTRO_NAME.tgz" -C /opt
	tar xzf "${SOURCES_DIR}/prometheus-client.tar.gz" -C /opt
	ls -lR /opt
	mv /opt/client_python-0.0.21/prometheus_client /opt/prometheus_client
	ls -lR /opt
}
chown -R 185:0 /opt/
