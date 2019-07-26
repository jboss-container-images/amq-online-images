LOCAL_ARTIFACT_DIR:=controller-manager/target/controller-manager-${VERSION}-dist.zip
OLM_VER := $(shell yq r ../templates/install/olm/amq-online/amq-online.package.yaml channels[0].currentCSV)

include ../Makefile.common

build: build/olm_manifest.tar.gz build/olm_package.tar.gz

build/olm_manifest.tar.gz: $(wildcard ../templates/install/olm/amq-online/*.clusterserviceversion.yaml ../templates/install/olm/amq-online/*.crd.yaml)
	@echo OLM_VER $(OLM_VER)
	mkdir -p build
	gtar czf $@ --transform 's,^,$(OLM_VER)/,' -C $(<D) $(^F)
	tar tzf $@

build/olm_package.tar.gz: ../templates/install/olm/amq-online/amq-online.package.yaml
	mkdir -p build
	tar czf $@ -C $(<D) $(^F)
	tar tzf $@
