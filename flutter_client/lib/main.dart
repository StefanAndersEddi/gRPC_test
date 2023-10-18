import 'package:flutter/material.dart';
import 'package:flutter_client/gen/message.pbgrpc.dart';
import 'package:grpc/grpc_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GRPCHome(),
    );
  }
}

class GRPCHome extends StatefulWidget {
  const GRPCHome({super.key});

  @override
  State<GRPCHome> createState() => _GRPCHomeState();
}

class _GRPCHomeState extends State<GRPCHome> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  Future<String> callMessageService() async {
    // Channel machen
    final channel =
        GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080'));

    // Client holen
    final client = MessageServiceClient(channel);

    // Mit dem Client lassen sich jetzt calls machen, die "so tun, als ob man einen lokalen Service benutzt".
    final reply = await client
        .greeting(MessageServiceRequest(name: _textEditingController.text));

    return reply.message;
  }

  @override
  Widget build(BuildContext context) {
    String serverReply = "Hier kommt dann die Serverantwort...";

    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            constraints: const BoxConstraints(
                minWidth: 100, maxWidth: 300, minHeight: 48, maxHeight: 96),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                  hintStyle: TextStyle(fontSize: 14),
                  alignLabelWithHint: true,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Tell your name...",
                  fillColor: Colors.white),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            serverReply,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            serverReply = await callMessageService();
          } catch (e) {
            serverReply = "Oh nein, hat leider nicht geklappt. Error: $e";
          }
          debugPrint(serverReply);
          setState(() {});
        },
      ),
    );
  }
}
