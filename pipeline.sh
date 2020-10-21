#!/bin/bash

set -x

set -o errexit -o pipefail
shopt -s globstar


function checkSpelling {
    docker run --rm -v $PWD:/work:ro -w /work tmaier/markdown-spellcheck:latest --report "**/*.md"
}

function checkLinks {
    echo **/*.md | xargs -n1 docker run --rm -v $PWD:/work:ro -w /work robertbeal/markdown-link-checker
}

eval "$@"
