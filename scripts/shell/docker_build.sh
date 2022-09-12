#!/usr/bin/env bash

docker build -t "$IMAGE" "$BUILD_CONTEXT"

# docker push

if [[ $IMAGE == *"locally" ]];then
    echo "this image is build locally and load into minikube ..."
    minikube image load $IMAGE
fi