#!/bin/bash

set -e
set -x
# docker buildx create --name mybuilder --driver docker-container --bootstrap

function build(){
  docker buildx use mybuilder

  local IMAGENAME=twistedbytes/centos${CENTOS_VERSION}-apachehttpd
  docker buildx build \
    --progress plain \
    --platform ${PLATFORMS} \
    --rm \
    -t "${IMAGENAME}:${IMAGE_VERSION}" \
    -t "${IMAGENAME}:latest" \
    --build-arg CENTOS_VERSION="${CENTOS_VERSION}" \
    --build-arg FROM_VERSION="${FROM_VERSION}" \
    --build-arg IMAGE_VERSION="${IMAGE_VERSION}" \
    --build-arg YUMDNF="${YUMDNF}" \
    --push \
    "${TEMPLATE_DIR}" &

#  docker tag "${IMAGENAME}:${IMAGE_VERSION}" "${IMAGENAME}:latest"
#
#  if [[ $PUSH -eq 1 ]]; then
#    docker push "${IMAGENAME}:${IMAGE_VERSION}"
#    docker push "${IMAGENAME}:latest"
#  fi
}

PUSH=1
IMAGE_VERSION=$( date +%Y.%m.%d ).01
TEMPLATE_DIR=centosX-apachehttpd
FROM_VERSION=$( cat centosX-stream/lastbuild-version.txt )

echo "${IMAGE_VERSION}" > ${TEMPLATE_DIR}/lastbuild-version.txt


# CENTOSVERSION
declare -a _BUILDS=(
  7@linux/amd64
  8@linux/amd64
  9@linux/amd64,linux/arm64
)

for i in "${_BUILDS[@]}"; do
  IFS=@ read CENTOS_VERSION PLATFORMS <<< $i

  if [[ $CENTOS_VERSION -eq 7 ]]; then
    YUMDNF=yum
  else
    YUMDNF=dnf
  fi

  echo "Building:"
  echo "CENTOS:  ${CENTOS_VERSION}"
  echo "PLATFORMS:  ${PLATFORMS}"
  build
done
