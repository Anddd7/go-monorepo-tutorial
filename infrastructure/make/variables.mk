############## REQUIRED ##############
#
# SERVICE_NAME	:= <service_name>
#
############## REQUIRED ##############

# !!!should be modified when generate new repo from this!!!

VAR_REPO_PATH 			:= golang/monorepo-tutorial
VAR_PROJECT_IDENTIFIER	:= github.com/anddd7/monorepo
VAR_ENV					?= dev-mac

# generic variables

VAR_RELATIVE_PATH		:= .
VAR_GIT_REVISION 		:= $(shell git rev-parse --verify --short HEAD 2>/dev/null)
VAR_GIT_ROOT_DIR    	:= $(shell git rev-parse --show-toplevel)
VAR_COMPILE_TIME 		:= $(shell git log -1 --format="%ad" --date=short)
VAR_ARGS_GO_BUILD 		:= CGO_ENABLED=0 GOOS=linux GOARCH=amd64
