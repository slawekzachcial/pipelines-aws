# Pipelines: AWS

This project implements a simple [Continuous Delivery
Pipeline](https://en.wikipedia.org/wiki/Continuous_delivery), based on [AWS
CodePipeline](https://aws.amazon.com/codepipeline/).

The repository is configured with [GitHub Pages](https://pages.github.com/).
The deployment consists of putting the content of the `main` branch into
`gh-pages` branch which publishes it to the
[website](https://slawekzachcial.github.io/pipelines-aws/).

The BASH snippets used in various tasks are implemented in `pipeline.sh` script.

## Spell Check

The pipeline checks the spelling of all markdown files in this repository.

## Link Check

The pipeline checks the links of all markdown files in this repository.

## Release Creation

The pipeline, when run on `main` branch, creates a new Git tag and GitHub
release. A new release is created only if one does not exist yet for the given
commit.

## Release Deployment

The pipeline, when run on `main` branch, deploys release by copying markdown
files into `gh-pages` branch. The deployment happens only if the markdown files
have been updated. The commit message in `gh-pages` branch contains the release
version number.
