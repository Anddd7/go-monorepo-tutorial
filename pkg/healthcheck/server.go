package healthcheck

import (
	"context"
	"log"

	"google.golang.org/grpc"
	this "google.golang.org/grpc/health/grpc_health_v1"
)

func RegisterHealthServer(s *grpc.Server) {
	this.RegisterHealthServer(s, &server{})
}

type server struct{}

func (s *server) Check(ctx context.Context, in *this.HealthCheckRequest) (*this.HealthCheckResponse, error) {
	log.Printf("Health Checking ... ... ...")
	return &this.HealthCheckResponse{Status: this.HealthCheckResponse_SERVING}, nil
}

func (s *server) Watch(in *this.HealthCheckRequest, w this.Health_WatchServer) error {
	log.Printf("Health Checking ... ... ... (Watching)")
	r := &this.HealthCheckResponse{Status: this.HealthCheckResponse_SERVING}
	for {
		w.Send(r)
	}
}
