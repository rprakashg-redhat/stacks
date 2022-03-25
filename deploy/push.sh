#!/usr/bin/env bash
REGISTRY="$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')"

GIT_REV="$(git rev-parse --short=7 HEAD)"
IMAGE="${REGISTRY}/registry/devfile-index"
IMAGE_TAG="${GIT_REV}"

podman login --tls-verify=false -u $(oc whoami) -p $(oc whoami -t) ${REGISTRY}

podman push "${IMAGE}:${IMAGE_TAG}"
podman push "${IMAGE}:next"
