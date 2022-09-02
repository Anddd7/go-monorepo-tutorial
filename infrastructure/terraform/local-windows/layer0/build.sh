#!/usr/bin/env bash

# example on AWS
# 1. create account to execute terraform
# 2. create s3 bucket as the backend, implement lock if needed
# 3. create vpc, subnets, access boundary and required policies.


echo "| build start: Layer0"
# --------------------------------------

# local-windows is just a local environment in windows wsl, so we'll use shell script instead of cloud provider setup.
# in this case, we don't need to do anything in local environment for layer0.

# --------------------------------------
echo "| build end: Layer0"
