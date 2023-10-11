#!/bin/bash

set -e

function build(){
  docker buildx use mybuilder

  local IMAGENAME=twistedbytes/setupproject

  docker buildx build \
    --platform ${PLATFORMS} \
    --rm \
    -t "${IMAGENAME}:${IMAGE_VERSION}" \
    -t "${IMAGENAME}:latest" \
    --build-arg YUMDNF="${YUMDNF}" \
    --push \
    "${TEMPLATE_DIR}"

#  docker tag "${IMAGENAME}:${IMAGE_VERSION}" "${IMAGENAME}:latest"
#
#  if [[ $PUSH -eq 1 ]]; then
#    docker push "${IMAGENAME}:${IMAGE_VERSION}"
#    docker push "${IMAGENAME}:latest"
#  fi
}

TEMPLATE_DIR=setupproject
IMAGE_VERSION=$( date +%Y.%m.%d ).01
PUSH=0

echo "${IMAGE_VERSION}" > ${TEMPLATE_DIR}/lastbuild-version.txt

# centos8 aarch64 does not have a remi repo
# CENTOSVERSION, PHP_MAJ, PHP_MIN PLATFORMS
declare -a _BUILDS=(
  # 9@linux/amd64,linux/arm64
  9@linux/amd64
  )

for i in "${_BUILDS[@]}"; do
  IFS=@ read CENTOS_VERSION PLATFORMS <<< $i

  if [[ $CENTOS_VERSION -eq 7 ]]; then
    YUMDNF=yum
  else
    YUMDNF=dnf
  fi

  echo "Building setupproject:"
  echo "CENTOS:  ${CENTOS_VERSION}"
  echo "PLATFORMS:  ${PLATFORMS}"
  build
done
