#!/usr/bin/env bash
# This script downloads the registry build tools and builds up this repository then pushes it to quay.io
# This will be run via the app-sre CI.
set -ex
ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GIT_REV="$(git rev-parse --short=7 HEAD)"
IMAGE="${IMAGE:-quay.io/rgopinat/devfile-index}"
IMAGE_TAG="${IMAGE_TAG:-${GIT_REV}}"

# Run the build script
$ABSOLUTE_PATH/build.sh

# Push the iamge to quay.io
if [[ -n "$QUAY_USER" && -n "$QUAY_TOKEN" ]]; then
    podman tag devfile-index "${IMAGE}:${IMAGE_TAG}"
    podman tag devfile-index "${IMAGE}:next"
    podman login -u="$QUAY_USER" -p="$QUAY_TOKEN" quay.io
    podman push "${IMAGE}:${IMAGE_TAG}"
    podman push "${IMAGE}:next"
fi