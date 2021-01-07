# Gitlab CI commons

## This repository

This is a collection of commons gitlab-ci.yml for specific project

## How to install and use it ?

1. Your default branch has to be "develop" and you should have another branch "master".
2. Include files you need in your CI.1
Example
```
include:
  - project: "Luc-AUCOIN/gitlab-ci--commons"
    file: angular.gitlab-ci.yml
  - project: "Luc-AUCOIN/gitlab-ci--commons"
    file: delivery.gitlab-ci.yml
```
For more detail have a look on the official [documentation](https://docs.gitlab.com/ee/ci/yaml/includes.html).
3. In your stage specify which part of the extended file you want to run:
Example:
```
extends: .angular-build-dev
```
For more detail have a look on the official [documentation](https://docs.gitlab.com/ee/ci/yaml/#extends).
4. Add the environment variable needed (look at the following parts)
For more detail have a look on the official [documentation](https://docs.gitlab.com/ee/ci/variables/).
5. Enjoy

### Delivery

In order to use it, please add the following environment variable(s) to your CI:
 - GITLAB_TOKEN: it's a personal access token with minimum the write privilege
 - CLOG_TOOL_VERSION: it's the release of [clog-cli](https://github.com/clog-tool/clog-cli)

### Docker

In order to use it, please add a Dockerfile in the root directory of your project.

### Angular

 - In order to use it, please add GITLAB_TOKEN (it's a personal access token with minimum the write privilege) to your environment varibles
 - If you want to use the release mode, please run a pipeline on your develop branch and add "RELEASE" as variable name and the release tag as value.

### Gradle

In order to use it:
 - Follow the installation instruction of this [repository](https://github.com/researchgate/gradle-release)
 - add GITLAB_TOKEN to your environment variable (it's a personal access token with minimum the write privilege)
 - If you want to use the release mode, please run a pipeline on your develop branch and add "RELEASE" as variable name and the release tag as value.

## Contributing

 - Create an issue and explain your problem
 - Fork it / Create your branch / Commit your changes / Push to your branch / Submit a pull request

## Maintainer

Luc AUCOIN <luc.aucoin1998@gmail.com>
