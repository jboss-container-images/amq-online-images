TOPDIR=$(dir $(lastword $(MAKEFILE_LIST)))

SUBDIRS=\
	standard-controller \
	address-space-controller \
	agent \
	topic-forwarder \
	auth-plugin \
	olm-manifest \
	service-broker \
	broker-plugin \
	none-auth-service \
	controller-manager \
	console-init \
	console-server

all: $(SUBDIRS) watchtaskall

push: $(SUBDIRS)

tag: $(SUBDIRS)

clean: $(SUBDIRS)

copyartifact: $(SUBDIRS)

listbuilds:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir listbuilds; \
	done

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

watchtaskall:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir watchtaskall; \
	done

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)


.PHONY: all $(SUBDIRS) \
	push tag clean copyartifact watchtaskall \
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
