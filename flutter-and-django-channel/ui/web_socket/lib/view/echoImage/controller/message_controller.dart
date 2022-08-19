import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// [https://www.piesocket.com/websocket-tester] adresten dummy websocket kullanılmıştır.

class ImageController extends GetxController {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  late final WebSocketChannel? channel;
  TextEditingController? textController = TextEditingController();

  void sendImage({dynamic data}) {
    if (data != null) {
      channel!.sink.add(data);
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
