package main

import (
	"github.com/anddd7/monorepo/services/order"
	"github.com/anddd7/monorepo/services/product"
)

type internal struct {
	product.ProductServiceClient
	order.OrderServiceClient
}

func main() {
	/*
		clients := internal{
			product.NewProductClient(""),
			order.NewOrderClient(""),
		}*/
}
