package order

import (
	"fmt"
	"log"

	"github.com/anddd7/monorepo/pkg/envs"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

func NewOrderClient(url string) InternalServiceClient {
	if url == "" {
		url = fmt.Sprintf("localhost:%v", envs.LocalOrderPort)
	}

	conn, err := grpc.Dial(url, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	return NewInternalServiceClient(conn)
}
