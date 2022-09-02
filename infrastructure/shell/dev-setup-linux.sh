#!/usr/bin/env bash

echo "1. install skaffold"

FILE=/usr/local/bin/skaffold
if test -f "$FILE"; then
    echo "$FILE exists."
else 
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
    sudo install skaffold /usr/local/bin/skaffold
    rm skaffold
fi

echo "0. install terraform"

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
