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

function getReleaseTag {
    local commitId="$1"
    git describe --tags --exact-match ${commitId} 2>/dev/null
}

function shouldDeploy {
    ! git diff origin/gh-pages --quiet -- README.md
}

function deployPages {
    local commitId="$1"
    local releaseVersion="$2"

    git config user.email slawekzachcial.pipelines-azure@dev.azure.com
    git config user.name 'Azure Pipelines'
    git status
    git switch gh-pages \
        && git restore --source ${commitId} README.md \
        && { git diff --quiet || { git commit -am "Deploy new release: ${releaseVersion}" && git push; } } \
        && git switch --detach  -
}

eval "$@"
