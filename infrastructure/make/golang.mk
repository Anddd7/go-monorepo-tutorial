# input variables

REPO_PATH 			:= ${VAR_REPO_PATH}
PROJECT_IDENTIFIER	:= ${VAR_PROJECT_IDENTIFIER}
ENV					:= ${VAR_ENV}
RELATIVE_PATH		:= ${VAR_RELATIVE_PATH}
GIT_REVISION 		:= ${VAR_GIT_REVISION}
GIT_ROOT_DIR    	:= ${VAR_GIT_ROOT_DIR}
COMPILE_TIME 		:= ${VAR_COMPILE_TIME}
ARGS_GO_BUILD 		:= ${VAR_ARGS_GO_BUILD}

# calculated variables

ROOT_DIR 			:= ${GIT_ROOT_DIR}/${REPO_PATH}
BUILD_DIR 			:= ${RELATIVE_PATH}/build
DEPLOY_DIR 			:= ${RELATIVE_PATH}/deploy
MAIN_ENTRY 			:= ${RELATIVE_PATH}/src/main.go

# commands

run: gen
	@echo ">> run service"
	@go run ${MAIN_ENTRY}

build: gen
	@echo ">> build the binary package"
	go build -o ${BUILD_DIR}/app ${MAIN_ENTRY}

# set the os and arch for the binary package
build-linux: gen
	@echo ">> build the binary package for linux(docker)"
	$(ARGS_GO_BUILD) go build -o ${BUILD_DIR}/app ${MAIN_ENTRY}

# build the docker image locally
# set the required envs manually
docker-local: export IMAGE=${PROJECT_IDENTIFIER}/${SERVICE_NAME}:${GIT_REVISION}-locally
docker-local: export BUILD_CONTEXT=${RELATIVE_PATH}
docker-local: build-linux docker-build

# build the docker image for skaffold
# please don't call this in your local
docker: build-linux docker-build

docker-build:
	@echo ">> build the docker image"
	$(ROOT_DIR)/infrastructure/shell/docker_build.sh

# cleanup the grpc stubs and binary
.PHONY:clean
clean:
	@rm -rf ${BUILD_DIR}
	@rm -f ${RELATIVE_PATH}/*.pb.go
