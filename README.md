# Red Hat AMQ Online container images

# License

See link: [LICENSE](LICENSE) file.

# Prerequisites

* Cekit version 3.x - https://cekit.readthedocs.io/en/latest/
* `operator-courier` – https://github.com/operator-framework/operator-courier
* yq - https://yq.readthedocs.io/en/latest/

# Re-generating templates

The script regenerate-templates.sh is responsible for the regenerating the contents of the ./templates directory given an
EnMasse git repository url.

    ./regenerate-templates.sh [--tag <tag>] [--keep-work-dir] [--help] <EnMasse git repository url> 

# Updating Go license files

Requires the tool [go-licenses](https://github.com/google/go-licenses)in `$PATH`. Requires Go 1.13 or higher.

    ./regenerate-go-license.sh [--tag <tag>] [--keep-work-dir] [--help] <EnMasse git repository url>

# Producing the install ZIP

    ./make_install_zip.sh <tag>

# Building images

Create a cekit config file

    cat > ~/.cekit/config << EOF
    [common]
    redhat = True
    EOF

## Building images locally

### [optional] Add local artifacts to cekit cache:

Set location of project to pull built artifacts from:

    export PRODUCT_DIR=../../enmasse-gerrit

Set the version that was used to build the artifacts

    export VERSION="0.29-SNAPSHOT"

Add artifacts to the cache, and update the image.yaml files with the md5

    make cacheartifactall

### Build the images

    kinit
    make

## Building images in osbs

    export CEKIT_BUILD_ENGINE=osbs
    export CEKIT_ENGINE_ARGS="--release --koji-target amq7-amq-online-1-rhel-7-containers-candidate --nowait"
    make

## Example of env variable to overridding contents of yaml file

    CEKIT_BUILD_ARGS="--overrides \"{'from': 'rhel7:7.6-.....'}\""

