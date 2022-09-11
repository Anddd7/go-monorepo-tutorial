package main

import (
	"context"
	"log"
	"os"

	"github.com/anddd7/monorepo/services/order"
	"github.com/anddd7/monorepo/services/product"
)

var (
	env = os.Getenv("ENV")
)

type internal struct {
	productClient product.InternalServiceClient
	orderClient   order.InternalServiceClient
}

func (s internal) run(ctx context.Context) {
	p, _ := s.productClient.GetProduct(ctx, &product.GetProductReq{Id: 1})
	o, _ := s.orderClient.CreateOrder(ctx, &order.CreateOrderReq{
		Name:      "orchestration-order",
		ProductId: []int64{p.GetId()},
	})
	log.Printf("create order successful, %v", o.GetId())
}

func main() {
	server := internal{
		productClient: product.NewProductClient(env),
		orderClient:   order.NewOrderClient(env),
	}
	server.run(context.Background())
}
