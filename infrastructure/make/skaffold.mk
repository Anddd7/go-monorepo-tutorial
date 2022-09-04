# input variables

RELATIVE_PATH		:= ${VAR_RELATIVE_PATH}
COMPILE_TIME		:= ${VAR_COMPILE_TIME}
GIT_ROOT_DIR		:= ${VAR_GIT_ROOT_DIR}
GIT_REVISION		:= ${VAR_GIT_REVISION}

# calculated variables

DEPLOY_DIR 			:= ${RELATIVE_PATH}/deploy
MANIFEST_FOLDER 	:= ${GIT_ROOT_DIR}/artifact/argocd/${ENV}/services/${SERVICE_NAME}
MANIFEST_FILE 		:= ${MANIFEST_FOLDER}/k8s.yaml

# required environment variables

export SERVICE_NAME=${SERVICE_NAME}

# commands
manifest-version:
	export VERSION=${COMPILE_TIME}-${GIT_REVISION}

# dry-run the kustomize output in overlay
dry-run: export IMAGE=${PROJECT_IDENTIFIER}/${SERVICE_NAME}:${GIT_REVISION}-locally
dry-run: manifest-version docker-local
	@echo ">> dry-run the kubernetes specs"
	kustomize build ${DEPLOY_DIR}/overlays/${ENV} | envsubst

manifest: export VERSION=${COMPILE_TIME}-${GIT_REVISION}
manifest: manifest-version docker
	@echo ">> dry-run the kubernetes specs"
	echo ${SERVICE_NAME}
	echo ${ENV}
#	mkdir -p ${MANIFEST_FOLDER}
#	kustomize build ${DEPLOY_DIR}/overlays/${ENV} | envsubst >| ${MANIFEST_FILE}
