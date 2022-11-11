# input variables

RELATIVE_PATH		:= ${VAR_RELATIVE_PATH}
COMPILE_TIME		:= ${VAR_COMPILE_TIME}
GIT_ROOT_DIR		:= ${VAR_GIT_ROOT_DIR}
GIT_REVISION		:= ${VAR_GIT_REVISION}

# calculated variables

KUSTOMIZE_DIR 		:= ${RELATIVE_PATH}/kustomize
BUILD_DIR 			:= ${RELATIVE_PATH}/build

# required environment variables

export SERVICE_NAME=${SERVICE_NAME}

# dry-run the kustomize output in overlay
dry-run: export IMAGE=ghcr.io/${OWNER_NAME}/${PROJECT_IDENTIFIER}/${SERVICE_NAME}:${GIT_REVISION}-locally
dry-run: export VERSION=v-${GIT_REVISION}-locally
dry-run: export DATE=${COMPILE_TIME}
dry-run: check-target-namespace docker-local
	@echo ">> dry-run the kubernetes specs"
	kustomize build ${KUSTOMIZE_DIR}/overlays/${TARGET_NAMESPACE} | envsubst

dry-run-yaml: export IMAGE=ghcr.io/${OWNER_NAME}/${PROJECT_IDENTIFIER}/${SERVICE_NAME}:${GIT_REVISION}-locally
dry-run-yaml: export VERSION=v-${GIT_REVISION}-locally
dry-run-yaml: export DATE=${COMPILE_TIME}
dry-run-yaml: check-target-namespace docker-local
	@echo ">> dry-run the kubernetes specs"
	kustomize build ${KUSTOMIZE_DIR}/overlays/${TARGET_NAMESPACE} | envsubst >| ${BUILD_DIR}/k8s.yaml

manifest: export VERSION=v-${GIT_REVISION}
manifest: export DATE=${COMPILE_TIME}
manifest: export OVERLAYS_FOLDER=${KUSTOMIZE_DIR}/overlays
manifest: export MANIFEST_FOLDER=${GIT_ROOT_DIR}/artifact/argocd
manifest: docker
	@echo ">> dry-run the kubernetes specs"
	$(ROOT_DIR)/scripts/shell/kustomize_build.sh

check-target-namespace:
ifndef TARGET_NAMESPACE
	$(error 'TARGET_NAMESPACE' is not set)
endif
