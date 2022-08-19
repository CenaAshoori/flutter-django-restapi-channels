import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// [https://www.piesocket.com/websocket-tester] adresten dummy websocket kullanılmıştır.

class MessageController extends GetxController {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  late final WebSocketChannel? channel;
  TextEditingController? textController = TextEditingController();

  void sendMessage({dynamic data}) {
    if (data != null || textController!.text.isNotEmpty) {
      channel!.sink.add(data ?? textController!.text);
    }
  }

  @override
  void onInit() {
    super.onInit();
    channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:8000/ws/'),
    );
  }

  @override
  void dispose() {
    channel!.sink.close();
    super.dispose();
  }
}
