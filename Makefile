TOPDIR=$(dir $(lastword $(MAKEFILE_LIST)))
SUBDIRS=standard-controller address-space-controller agent mqtt-gateway mqtt-lwt topic-forwarder auth-controller auth-plugin api-server service-broker broker-plugin

all:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done	

pushall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir push; \
	done

tagall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir tag; \
	done

cleanall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

copyartifactall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir copyartifact; \
	done

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: all $(SUBDIRS) push tag clean pushall tagall cleanall
