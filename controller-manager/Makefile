LOCAL_ARTIFACT_DIR:=controller-manager/target/controller-manager-${VERSION}-dist.zip

include ../Makefile.common

build: build/manifests.tar.gz

build/manifests.tar.gz: $(wildcard ../templates/install/olm/amq-online/*.yaml)
	mkdir -p build
	tar czf $@ -C $(<D) $(^F)
	tar tzf $@
