#!/usr/bin/env bash

echo "| destroy start: Layer1"
# --------------------------------------

echo "1. drop minikube"

minikube stop
minikube delete

# --------------------------------------
echo "| destroy end: Layer1"
