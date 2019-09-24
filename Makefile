TOPDIR=$(dir $(lastword $(MAKEFILE_LIST)))

SUBDIRS=\
	standard-controller \
	address-space-controller \
	agent \
	mqtt-gateway \
	mqtt-lwt \
	topic-forwarder \
	auth-plugin \
	api-server \
	service-broker \
	broker-plugin \
	none-auth-service \
	controller-manager \
	console-init \
	console-httpd \
	iot-auth-service \
	iot-device-registry-file \
	iot-device-registry-datagrid \
	iot-http-adapter \
	iot-mqtt-adapter \
	iot-proxy-configurator \
	iot-tenant-service \


all: $(SUBDIRS)

push: $(SUBDIRS)

tag: $(SUBDIRS)

clean: $(SUBDIRS)

copyartifact: $(SUBDIRS)

listbuildids:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir listbuildid; \
	done

pushfrombrewall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir pushfrombrew; \
	done

cacheartifactall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir cacheartifact; \
	done

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: all $(SUBDIRS) \
	push tag clean copyartifact \
	pushall tagall cleanall copyartifactall

# legacy targets

pushall:
	$(MAKE) push

tagall:
	$(MAKE) tag

cleanall:
	$(MAKE) clean

copyartifactall:
	$(MAKE) copyartifact
