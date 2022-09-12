GIT_REVISION 		:= $(shell git rev-parse --verify --short HEAD 2>/dev/null)
COMPILE_TIME 		:= $(shell git log -1 --format="%ad" --date=short)
ENV 				?= wsl-ubuntu-dev

build: export TARGET_ENV=${ENV}
build:
	skaffold build -p ${ENV}
	./scripts/shell/argocd_push.sh 'in ${GIT_REVISION} at ${COMPILE_TIME}'

setup-linux:
	./scripts/shell/dev-setup-linux.sh

setup-macos:
	./scripts/shell/dev-setup-macos.sh
