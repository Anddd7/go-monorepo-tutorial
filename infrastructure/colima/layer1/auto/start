#!/usr/bin/env bash

# on kubernetes
# 1. create kubernetes cluster
# 2. install supporting services and tools

echo "| build start: Layer1"
# --------------------------------------

echo "1. install colima"

FILE=/usr/local/bin/colima
if test -f "$FILE"; then
    echo "$FILE exists."
else
    brew install colima
fi

echo "2. start kubernetes cluster in colima"

colima start --kubernetes

echo "3. install supporting resources into k8s cluster"

terraform apply -auto-approve

# --------------------------------------
echo "| build end: Layer1"
