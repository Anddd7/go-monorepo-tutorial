# terraform structure

## Platform Level

available platform

- macos
- wsl-ubuntu
- aws
- gcp
- alicloud

modules, create the standard and reusable modules

- reusable resources
- services
- apps

## Infrastructure Layer level

### layer0: set up the platform to build the fundamental things

e.g.

- account setup
- remote state
- access boundary
- networking

### layer1: start the cluster and inbound & outbound traffic

e.g.

- kubernetes cluster
- install supporting services and tools

### layer2: deploy the applications via configurations

e.g.

- config and secret
- environment variables

## Environment Level

- dev
- qa
- stg
- prd
