# input variables

RELATIVE_PATH		:= ${VAR_RELATIVE_PATH}
COMPILE_TIME		:= ${VAR_COMPILE_TIME}
GIT_ROOT_DIR		:= ${VAR_GIT_ROOT_DIR}
GIT_REVISION		:= ${VAR_GIT_REVISION}

# calculated variables

KUSTOMIZE_DIR 		:= ${RELATIVE_PATH}/kustomize
BUILD_DIR 			:= ${RELATIVE_PATH}/build
MANIFEST_FOLDER 	:= ${GIT_ROOT_DIR}/artifact/argocd/${TARGET_ENV}/services

# required environment variables

export SERVICE_NAME=${SERVICE_NAME}


# dry-run the kustomize output in overlay
dry-run: export IMAGE=${PROJECT_IDENTIFIER}/${SERVICE_NAME}:${GIT_REVISION}-locally
dry-run: export VERSION=v-${GIT_REVISION}-locally
dry-run: export DATE=${COMPILE_TIME}
dry-run: docker-local
	@echo ">> dry-run the kubernetes specs"
	kustomize build ${KUSTOMIZE_DIR}/overlays/${TARGET_ENV} | envsubst

dry-run-yaml: export IMAGE=${PROJECT_IDENTIFIER}/${SERVICE_NAME}:${GIT_REVISION}-locally
dry-run-yaml: export VERSION=v-${GIT_REVISION}-locally
dry-run-yaml: export DATE=${COMPILE_TIME}
dry-run-yaml: docker-local
	@echo ">> dry-run the kubernetes specs"
	kustomize build ${KUSTOMIZE_DIR}/overlays/${TARGET_ENV} | envsubst >| ${BUILD_DIR}/k8s.yaml

manifest: export VERSION=v-${GIT_REVISION}
manifest: export DATE=${COMPILE_TIME}
manifest: docker
	@echo ">> dry-run the kubernetes specs"
	mkdir -p ${GIT_ROOT_DIR}/artifact/argocd/${TARGET_ENV}/services/${SERVICE_NAME}
	kustomize build ${KUSTOMIZE_DIR}/overlays/${TARGET_ENV} | envsubst >| ${MANIFEST_FOLDER}/${SERVICE_NAME}/k8s.yaml
