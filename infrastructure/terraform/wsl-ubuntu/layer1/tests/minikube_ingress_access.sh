#!/usr/bin/env bash

# create connection to the svc and get the url(with port)
minikube service ingress-nginx-controller -n ingress-nginx --url

# curl the service via ingress with dedicate host
curl 127.0.0.1:44587 -H 'Host: hello-world.info'        

curl -k https://127.0.0.1:33373 -H 'Host: argocd.wsl-ubuntu.anddd7.io'