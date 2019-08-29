# Red Hat AMQ Online container images

# License

See link: [LICENSE](LICENSE) file.

# Prerequisites

* Cekit - https://cekit.readthedocs.io/en/latest/

# Re-generating templates

The script regenerate-templates.sh is responsible for regenerating the contents of the `./templates` directory given an
EnMasse git repository url.

    ./regenerate-templates.sh [--tag <tag>] [--keep-work-dir] [--help] <EnMasse git repository url> 

# Updating Go license files

Requires the tools [retrodep](https://github.com/release-engineering/retrodep) and
[licenseclassifier](https://github.com/google/licenseclassifier) in `$PATH`

    ./regenerate-go-license.sh [--tag <tag>] [--keep-work-dir] [--help] <EnMasse git repository url>

# Producing the install ZIP

./make_install_zip.sh <tag>

