#!/usr/bin/env bash

for subfolder in "${OVERLAYS_FOLDER}"/**; do
  target_namespace="${subfolder##*/}"
  source_dir=${OVERLAYS_FOLDER}/${target_namespace}
  target_dir=${MANIFEST_FOLDER}/${target_namespace}/services/${SERVICE_NAME}
  mkdir -p "$target_dir"
  kustomize build "${source_dir}" | envsubst >|"${target_dir}"/k8s.yaml
done
