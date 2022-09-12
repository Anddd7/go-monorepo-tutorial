#!/usr/bin/env bash

msg=${1}

cd ./artifact/argocd

git add . 
git commit -m "generated manifest ${msg}"
git push