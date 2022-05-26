#!/bin/bash

set -e

function build(){
  docker build \
    --rm -t "${IMAGENAME}:${IMAGE_VERSION}" \
    --build-arg CENTOS_VERSION=${CENTOS_VERSION} \
    --build-arg IMAGE_VERSION=${IMAGE_VERSION} \
    ${TEMPLATE_DIR}

  docker tag "${IMAGENAME}:${IMAGE_VERSION}" "${IMAGENAME}:latest"

  if [[ $PUSH -eq 1 ]]; then
    docker push "${IMAGENAME}:${IMAGE_VERSION}"
    docker push "${IMAGENAME}:latest"
  fi
}

PUSH=1
IMAGE_VERSION=2022.05.26.02
TEMPLATE_DIR=centosX-stream

echo ${IMAGE_VERSION} > ${TEMPLATE_DIR}/lastbuild-version.txt

CENTOS_VERSION=8
IMAGENAME=twistedbytes/centos${CENTOS_VERSION}-stream
build

CENTOS_VERSION=9
IMAGENAME=twistedbytes/centos${CENTOS_VERSION}-stream
build
