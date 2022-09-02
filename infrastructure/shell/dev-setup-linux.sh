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