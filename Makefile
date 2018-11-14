SUBDIRS=standard-controller address-space-controller agent mqtt-gateway mqtt-lwt topic-forwarder auth-controller auth-plugin api-server service-broker broker-plugin

all:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done	

pushall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir push; \
	done

snapshotall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir snapshot; \
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

.PHONY: all $(SUBDIRS) push snapshot clean pushall snapshotall cleanall
