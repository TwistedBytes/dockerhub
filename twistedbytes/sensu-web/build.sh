
docker buildx use mybuilder
PLATFORMS="linux/amd64"
IMAGE_NAME="twistedbytes/sensuweb-fix"
IMAGE_VERSION=$( date +%Y.%m.%d ).01
TEMPLATE_DIR="."
_DOCKERFILE="${TEMPLATE_DIR}/Dockerfile"

docker buildx build \
  --progress plain \
  --platform ${PLATFORMS} \
  --rm \
  -t "${IMAGE_NAME}:${IMAGE_VERSION}" \
  -t "${IMAGE_NAME}:latest" \
  --push \
  -f "${_DOCKERFILE}" \
  "${TEMPLATE_DIR}"
