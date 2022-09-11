package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"os"
	"strconv"

	"google.golang.org/grpc"

	"github.com/anddd7/monorepo/pkg/envs"
	"github.com/anddd7/monorepo/pkg/healthcheck"
	this "github.com/anddd7/monorepo/services/order"
	"github.com/anddd7/monorepo/services/product"
)

var (
	env  = os.Getenv("ENV")
	port = envs.GetEnvOrStr("PORT", strconv.Itoa(envs.LocalOrderPort))
)

type server struct {
	productClient product.InternalServiceClient
}

func (s server) GetOrder(ctx context.Context, req *this.GetOrderReq) (*this.Order, error) {
	p1, _ := s.productClient.GetProduct(ctx, &product.GetProductReq{Id: 1})
	p2, _ := s.productClient.GetProduct(ctx, &product.GetProductReq{Id: 2})
	p3, _ := s.productClient.GetProduct(ctx, &product.GetProductReq{Id: 3})
	products := []*product.Product{p1, p2, p3}
	var totalPriceCent int32
	for _, p := range products {
		totalPriceCent += p.GetPriceCent()
	}

	return &this.Order{
		Id:             req.GetId(),
		Products:       products,
		TotalPriceCent: totalPriceCent,
		Status:         0,
	}, nil
}
func (s server) CreateOrder(ctx context.Context, req *this.CreateOrderReq) (*this.CreateOrderResp, error) {
	return &this.CreateOrderResp{
		Id: 1,
	}, nil
}

func register(s *grpc.Server) {
	productClient := product.NewProductClient(env)
	this.RegisterInternalServiceServer(s, &server{
		productClient: productClient,
	})
}

func main() {
	listener, err := net.Listen("tcp", fmt.Sprintf(":%s", port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	register(s)
	healthcheck.RegisterHealthServer(s)
	log.Printf("server listening at %v", listener.Addr())
	if err := s.Serve(listener); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
