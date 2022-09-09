#!/usr/bin/env bash

# on kubernetes
# 1. create kubernetes cluster
# 2. install supporting services and tools

echo "| build start: Layer1"
# --------------------------------------

echo "1. install minikube"

FILE=/usr/local/bin/minikube
if test -f "$FILE"; then
    echo "$FILE exists."
else
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube/usr/local/bin/minikube
    rm minikube
fi

echo "2. start kubernetes cluster in minikube"

minikube start --memory=16384 --cpus=4

echo "3. install supporting resources into k8s cluster"

# dashboard
minikube addons enable dashboard 
# ingress
minikube addons enable ingress 
# istio
minikube addons enable istio-provisioner 
minikube addons enable istio 
# others
# TODO resolve ingress access issue
# terraform apply -auto-approve

# --------------------------------------
echo "| build end: Layer1"
