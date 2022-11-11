#!/usr/bin/env bash

echo "1.1. install skaffold"

FILE=/usr/local/bin/skaffold
if test -f "$FILE"; then
    echo "$FILE exists."
else 
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
    sudo install skaffold /usr/local/bin/skaffold
    rm skaffold
fi


echo "1.2. install grpc"

FILE=/usr/bin/protoc
if test -f "$FILE"; then
    echo "$FILE exists."
else 
    sudo apt install -y protobuf-compiler
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
fi

echo "1.3. install kustomize"

FILE=/usr/local/bin/kustomize
if test -f "$FILE"; then
    echo "$FILE exists."
else 
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
    sudo install kustomize /usr/local/bin/kustomize
    rm kustomize
fi

# -------------------------------------------------------------

echo "2.1. install terraform"

FILE=/usr/bin/terraform
if test -f "$FILE"; then
    echo "$FILE exists."
else 
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

    gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update
    sudo apt-get install terraform
fi
