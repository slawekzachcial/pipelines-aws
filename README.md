# Pipelines: AWS

This project intended to implement a simple [Continuous Delivery
Pipeline](https://en.wikipedia.org/wiki/Continuous_delivery), based on [AWS
CodePipeline](https://aws.amazon.com/codepipeline/).

The repository is configured with [GitHub Pages](https://pages.github.com/).
The deployment should have consisted of putting the content of the `main`
branch into `gh-pages` branch which publishes it to the
[website](https://slawekzachcial.github.io/pipelines-aws/).

The BASH snippets used in various tasks are implemented in `pipeline.sh` script.

The pipeline was intended to have four stages
* Spell check - checks the spelling of all markdown files in this repository
* Link check - checks the links of all markdown files in this repository
* Release creation - the pipeline, when run on `main` branch, creates a new Git
  tag and GitHub release. A new release is created only if one does not exist
  yet for the given commit
* Release deployment - the pipeline, when run on `main` branch, deploys release
  by copying markdown files into `gh-pages` branch. The deployment happens only
  if the markdown files have been updated. The commit message in `gh-pages`
  branch contains the release version number

**UNFORTUNATELY** AWS CodePipeline and CodeBuild does not clone the Git
repository it builds and so the `.git` metadata is not available. This means
that the creation of Git tag or merging of Git branches is not possible.

To make it possible additional commands would have to be added to clone the
repository.  This in turn would require to hardcode in the `buildspec.yml` the
Git repository URL as none is available in environment variables and the Git
branch name (e.g. to differentiate a build of `main` branch from a build of
pull request branch. Finally, to push Git commits credentials would also have
to be provided and handled. All of this, while technically possible, requires
quite a bit of hardcoding and scripting. Having to do this means that AWS
CodePipeline and CodeBuild are not suited for scenarios where CI/CD job needs
to perform Git operations.
