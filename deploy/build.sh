#!/usr/bin/env bash

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REGISTRY=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')

GIT_REV="$(git rev-parse --short=7 HEAD)"
IMAGE="${REGISTRY}/rgopinat/devfile-index"
IMAGE_TAG="${GIT_REV}"

podman build --no-cache -t "${IMAGE}:${IMAGE_TAG}" -f $ABSOLUTE_PATH/Dockerfile $ABSOLUTE_PATH/..

if [[ -n "$QUAY_USER" && -n "$QUAY_TOKEN" ]]; then
    podman tag "${IMAGE}:${IMAGE_TAG}" "${IMAGE}:next"
    podman login -u $(oc whoami) -p $(oc whoami -t) $REGISTRY
    podman push "${IMAGE}:${IMAGE_TAG}"
    podman push "${IMAGE}:next"
fi
