
# current directory (note: use ':=' in order to evaluate now)
TOPDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

all: build

build:
	operator-courier verify --ui_validate_io "$(TOPDIR)/install/olm/amq-online"

.PHONY: all push tag clean pushall tagall cleanall
