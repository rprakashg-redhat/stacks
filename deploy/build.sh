#!/usr/bin/env bash

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REGISTRY="$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')"

GIT_REV="$(git rev-parse --short=7 HEAD)"
IMAGE="${REGISTRY}/registry/devfile-index"
IMAGE_TAG="${GIT_REV}"

podman build --no-cache -t "${IMAGE}:${IMAGE_TAG}" -f $ABSOLUTE_PATH/Dockerfile $ABSOLUTE_PATH/..
podman tag "${IMAGE}:${IMAGE_TAG}" "${IMAGE}:next"

