#!/bin/bash

set -e

function build(){
  local PHP_VERSION_MAJOR_MINOR=${PHP_VERSION_MAJOR}.${PHP_VERSION_MINOR}
  local IMAGENAME=twistedbytes/centos${CENTOS_VERSION}-php${PHP_VERSION_MAJOR}${PHP_VERSION_MINOR}

  docker build \
    --rm -t "${IMAGENAME}:${IMAGE_VERSION}" \
    --build-arg CENTOS_VERSION="${CENTOS_VERSION}" \
    --build-arg FROM_VERSION="${FROM_VERSION}" \
    --build-arg PHP_VERSION_MAJOR="${PHP_VERSION_MAJOR}" \
    --build-arg PHP_VERSION_MAJOR_MINOR="${PHP_VERSION_MAJOR_MINOR}" \
    --build-arg IMAGE_VERSION="${IMAGE_VERSION}" \
    "${TEMPLATE_DIR}"

  docker tag "${IMAGENAME}:${IMAGE_VERSION}" "${IMAGENAME}:latest"

  if [[ $PUSH -eq 1 ]]; then
    docker push "${IMAGENAME}:${IMAGE_VERSION}"
    docker push "${IMAGENAME}:latest"
  fi
}

FROM_VERSION=$( cat centosX-stream/lastbuild-version.txt )
TEMPLATE_DIR=centosX-phpXX
IMAGE_VERSION=$( date +%Y.%m.%d ).01
PUSH=1

echo "${IMAGE_VERSION}" > ${TEMPLATE_DIR}/lastbuild-version.txt

# CENTOSVERSION, PHP_MAJ, PHP_MIN
declare -a _BUILDS=(
  8,7,4
  8,8,0
  8,8,1
  8,8,2
  9,8,0
  9,8,1
  9,8,2
  )

for i in "${_BUILDS[@]}"; do
   IFS=, read CENTOS_VERSION PHP_VERSION_MAJOR PHP_VERSION_MINOR <<< $i
   echo "Building:"
   echo "FROM:    ${FROM_VERSION}"
   echo "CENTOS:  ${CENTOS_VERSION}"
   echo "PHP:     ${PHP_VERSION_MAJOR}.${PHP_VERSION_MINOR}"
   build
done
