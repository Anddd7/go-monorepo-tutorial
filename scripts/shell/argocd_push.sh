#!/usr/bin/env bash

msg=${1}

cd ./artifact/argocd

if [ "$CI" = true ] ; then
    git config user.email "actions@github.com"
    git config user.name "GitHub Actions - update submodules"
fi

git add -A
git commit -m "auto generated manifest ${msg}" || echo "No changes to commit"
git push origin HEAD:master
