#!/usr/bin/env bash

docker build \
  --label "org.opencontainers.image.source=$REPO_URL" \
  -t "$IMAGE" \
  "$BUILD_CONTEXT"

if [ "$CI" = true ]; then
  echo "this image is push to remote server ..."
  docker push "$IMAGE"
else
  echo "this image is build locally and load into minikube ..."
  minikube image load "$IMAGE"
fi
