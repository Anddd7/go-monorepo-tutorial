#!/usr/bin/env bash

echo "1.1. install skaffold"

FILE=/usr/local/bin/skaffold
if test -f "$FILE"; then
  echo "$FILE exists."
else
  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-darwin-amd64
  sudo install skaffold /usr/local/bin/skaffold
  rm skaffold
fi

echo "1.2. install grpc"

FILE=/usr/local/bin/protoc
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
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
  sudo install kustomize /usr/local/bin/kustomize
  rm kustomize
fi

# -------------------------------------------------------------

echo "2.1. install terraform"

FILE=/usr/local/bin/terraform
if test -f "$FILE"; then
  echo "$FILE exists."
else
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
fi
