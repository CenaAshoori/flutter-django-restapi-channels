import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:web_socket/view/note/controller/network.dart';
import 'package:web_socket/view/note/models/note_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// [https://www.piesocket.com/websocket-tester] adresten dummy websocket kullanılmıştır.

class NoteController extends GetxController {
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  var notes = <Note>[].obs;

  void get_notes() async {
    notes(await ApiNote().get_all_notes());
    update();
  }

  TextEditingController? textController = TextEditingController();
}
