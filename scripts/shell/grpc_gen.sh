#!/usr/bin/env bash

root_dir=$(go env GOMOD | xargs dirname)
services_path=services

cd "${root_dir}/${services_path}" || exit

protoc -I. \
    --go_out=paths=source_relative:. \
    --go-grpc_out=require_unimplemented_servers=false,paths=source_relative:. \
    ./**/*.proto
