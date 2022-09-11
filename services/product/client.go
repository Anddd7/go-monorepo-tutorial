package product

import (
	"fmt"
	"log"

	"github.com/anddd7/monorepo/pkg/envs"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func NewProductClient(env string) InternalServiceClient {
	conn, err := grpc.Dial(getUrl(env), grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	return NewInternalServiceClient(conn)
}

func getUrl(env string) string {
	if env == "" {
		return fmt.Sprintf("localhost:%v", envs.LocalProductPort)
	}
	return "product:50051"
}
