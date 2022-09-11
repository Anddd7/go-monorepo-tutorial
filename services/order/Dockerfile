FROM gcr.io/distroless/base-debian10

# Kubernetes v1.23 has now introduced built-in gRPC health checking 
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-a-grpc-liveness-probe
# 
# RUN GRPC_HEALTH_PROBE_VERSION=v0.3.1 && \
#     wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
#     chmod +x /bin/grpc_health_probe

WORKDIR /

COPY ./build/app /app

USER nonroot:nonroot

ENTRYPOINT ["/app"]
