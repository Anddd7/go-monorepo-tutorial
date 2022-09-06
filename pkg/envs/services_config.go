package envs

import (
	"log"
	"os"
)

const (
	LocalProductPort = 50051
	LocalOrderPort   = 50052
)

func GetEnvOrStr(name string, value string) string {
	v := os.Getenv(name)
	if v == "" {
		return value
	}
	return v
}

func GetEnvOrPanic(name string) string {
	v := os.Getenv(name)
	if v == "" {
		log.Fatalf("missing environment variable: %v", v)
	}
	return v
}
