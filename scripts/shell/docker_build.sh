#!/usr/bin/env bash

echo "$CR_PAT" | docker login ghcr.io -u "$OWNER_NAME" --password-stdin

docker build \
  --label "org.opencontainers.image.source=$REPO_URL" \
  -t "$IMAGE" \
  "$BUILD_CONTEXT"

# docker push

if [[ $IMAGE == *"locally" ]];then
    echo "this image is build locally and load into minikube ..."
    minikube image load "$IMAGE"
fi

docker push "$IMAGE"
