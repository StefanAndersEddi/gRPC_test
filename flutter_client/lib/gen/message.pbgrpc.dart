//
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'message.pb.dart' as $0;

export 'message.pb.dart';

@$pb.GrpcServiceName('MessageService')
class MessageServiceClient extends $grpc.Client {
  static final _$greeting = $grpc.ClientMethod<$0.MessageServiceRequest, $0.MessageServiceReply>(
      '/MessageService/Greeting',
      ($0.MessageServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MessageServiceReply.fromBuffer(value));

  MessageServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.MessageServiceReply> greeting($0.MessageServiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$greeting, request, options: options);
  }
}

@$pb.GrpcServiceName('MessageService')
abstract class MessageServiceBase extends $grpc.Service {
  $core.String get $name => 'MessageService';

  MessageServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.MessageServiceRequest, $0.MessageServiceReply>(
        'Greeting',
        greeting_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MessageServiceRequest.fromBuffer(value),
        ($0.MessageServiceReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.MessageServiceReply> greeting_Pre($grpc.ServiceCall call, $async.Future<$0.MessageServiceRequest> request) async {
    return greeting(call, await request);
  }

  $async.Future<$0.MessageServiceReply> greeting($grpc.ServiceCall call, $0.MessageServiceRequest request);
}
