# input variables

REPO_PATH 		:= ${VAR_REPO_PATH}
GIT_ROOT_DIR    := ${VAR_GIT_ROOT_DIR}

# calculated variables

ROOT_DIR 		:= ${GIT_ROOT_DIR}/${REPO_PATH}

# commands

gen:
	@echo ">> generating grpc"
	$(ROOT_DIR)/infrastructure/shell/grpc_gen.sh
