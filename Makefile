VAR_GIT_REVISION 		:= $(shell git rev-parse --verify --short HEAD 2>/dev/null)
VAR_COMPILE_TIME 		:= $(shell git log -1 --format="%ad" --date=short)

build:
	skaffold build
	./infrastructure/shell/argocd_push.sh 'in ${VAR_GIT_REVISION} at ${VAR_COMPILE_TIME}'
	
setup-linux:
	./infrastructure/shell/dev-setup-linux.sh