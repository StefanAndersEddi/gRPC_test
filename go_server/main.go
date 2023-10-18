package main

import (
	"context"
	"fmt"
	gen "go-server/gen"
	"log"
	"net"

	"google.golang.org/grpc"
)

func main() {
	// Port definieren
	port := ":8080" //flag.Int("port", 8080, "The server port")

	// Listener definieren & Port zuweisen
	listener, err := net.Listen("tcp", port)

	if err != nil {
		log.Fatalf("Failed to listen, error: %v", err)
	}

	// Blanken gRPC-Server ohne Services definieren
	grpcServer := grpc.NewServer()
	
	// Unseren generierten Server bei gRPC-Server registrieren
	gen.RegisterMessageServiceServer(grpcServer, &Server{})

	log.Printf("Server is listening at %v", listener.Addr())

	// gRPC-Server am Port horchen lassen (per Listener)
	err = grpcServer.Serve(listener)
	if err != nil {
		log.Fatalf("Failed to server: %v", err)
	}
}

type Server struct {
	gen.UnimplementedMessageServiceServer
}

// Implementierung der generierten, von uns definierten "Greeting"-Funktion. Hässlich! 
func (server *Server) Greeting(ctx context.Context, in *gen.MessageServiceRequest) (*gen.MessageServiceReply, error) {
	log.Println("Received from Flutter, hooray! Your name seems to be:", in.Name)
	return &gen.MessageServiceReply{Message: fmt.Sprintf("Hi from the server, %v!", in.Name)}, nil
}
