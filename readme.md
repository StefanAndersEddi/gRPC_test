Um Proto-files zu generieren:

Dart:
protoc --dart_out=grpc:lib/gen -I lib lib/message.proto

Go:
protoc *.proto --go_out=gen --go-grpc_out=gen