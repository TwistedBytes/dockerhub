#!/bin/bash

set -e

function build(){
  docker buildx use mybuilder

  local PHP_VERSION_MAJOR_MINOR=${PHP_VERSION_MAJOR}.${PHP_VERSION_MINOR}
  local PHP_VERSION_MAJOR_MINOR2=${PHP_VERSION_MAJOR}${PHP_VERSION_MINOR}
  local IMAGENAME=twistedbytes/centos${CENTOS_VERSION}-php${PHP_VERSION_MAJOR_MINOR2}

  if [[ $CENTOS_VERSION -eq 7 ]]; then
    _DOCKERFILE="${TEMPLATE_DIR}/Dockerfile-centos${CENTOS_VERSION}"
  else
    _DOCKERFILE="${TEMPLATE_DIR}/Dockerfile"
  fi

  docker buildx build \
    --progress plain \
    --platform ${PLATFORMS} \
    --rm \
    -t "${IMAGENAME}:${IMAGE_VERSION}" \
    -t "${IMAGENAME}:latest" \
    --build-arg CENTOS_VERSION="${CENTOS_VERSION}" \
    --build-arg FROM_VERSION="${FROM_VERSION}" \
    --build-arg PHP_VERSION_MAJOR="${PHP_VERSION_MAJOR}" \
    --build-arg PHP_VERSION_MAJOR_MINOR="${PHP_VERSION_MAJOR_MINOR}" \
    --build-arg PHP_VERSION_MAJOR_MINOR2="${PHP_VERSION_MAJOR_MINOR2}" \
    --build-arg IMAGE_VERSION="${IMAGE_VERSION}" \
    --build-arg YUMDNF="${YUMDNF}" \
    --push \
    -f "${_DOCKERFILE}" \
    "${TEMPLATE_DIR}"

#  docker tag "${IMAGENAME}:${IMAGE_VERSION}" "${IMAGENAME}:latest"
#
#  if [[ $PUSH -eq 1 ]]; then
#    docker push "${IMAGENAME}:${IMAGE_VERSION}"
#    docker push "${IMAGENAME}:latest"
#  fi
}

FROM_VERSION=$( cat centosX-stream/lastbuild-version.txt )
TEMPLATE_DIR=centosX-phpXX
IMAGE_VERSION=$( date +%Y.%m.%d ).01
PUSH=1

echo "${IMAGE_VERSION}" > ${TEMPLATE_DIR}/lastbuild-version.txt

# centos8 aarch64 does not have a remi repo
# CENTOSVERSION, PHP_MAJ, PHP_MIN PLATFORMS
declare -a _BUILDS=(
  7@5@6@linux/amd64 #,linux/arm64
  8@7@2@linux/amd64,linux/arm64
  8@7@3@linux/amd64,linux/arm64
  8@7@4@linux/amd64,linux/arm64
  8@8@0@linux/amd64,linux/arm64
  8@8@1@linux/amd64,linux/arm64
  8@8@2@linux/amd64,linux/arm64
  8@8@3@linux/amd64,linux/arm64
  9@7@4@linux/amd64,linux/arm64
  9@8@0@linux/amd64,linux/arm64
  9@8@1@linux/amd64,linux/arm64
  9@8@2@linux/amd64,linux/arm64
  9@8@3@linux/amd64,linux/arm64
  9@8@4@linux/amd64,linux/arm64
  )

for i in "${_BUILDS[@]}"; do
  IFS=@ read CENTOS_VERSION PHP_VERSION_MAJOR PHP_VERSION_MINOR PLATFORMS <<< $i

  if [[ $CENTOS_VERSION -eq 7 ]]; then
    YUMDNF=yum
  else
    YUMDNF=dnf
  fi

  echo "Building:"
  echo "CENTOS:  ${CENTOS_VERSION}"
  echo "PLATFORMS:  ${PLATFORMS}"
  echo "FROM:    ${FROM_VERSION}"
  echo "PHP:     ${PHP_VERSION_MAJOR}.${PHP_VERSION_MINOR}"
  build
done
