#!/bin/bash

set -e

function build(){
  local IMAGENAME=twistedbytes/centos${CENTOS_VERSION}-stream
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
IMAGE_VERSION=`date +%Y.%m.%d`.01
TEMPLATE_DIR=centosX-stream

echo ${IMAGE_VERSION} > ${TEMPLATE_DIR}/lastbuild-version.txt


# CENTOSVERSION
declare -a _BUILDS=(
  8
  9
  )

for i in "${_BUILDS[@]}"; do
   IFS=, read CENTOS_VERSION <<< $i
   echo $CENTOS_VERSION
   build
done
