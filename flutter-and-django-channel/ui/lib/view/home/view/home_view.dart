import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket/view/echoImage/view/image_view.dart';
import 'package:web_socket/view/message/view/message_view.dart';
import 'package:web_socket/view/messenger/pages/dashboard/dashboard.dart';
import 'package:web_socket/view/messenger/view/messenger_view.dart';
import 'package:web_socket/view/note/view/note_view.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 10,
      children: [
        grid_item("Note", NoteView("Note View")),
        grid_item("Message", MessageView("Message View")),
        grid_item("Image", ImageView("Image View")),
        grid_item("Chat", MyDashBoard()),
      ],
    ));
  }

  Container grid_item(String title, Widget widget) {
    final colors = [
      Colors.amber,
      Colors.green,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.redAccent,
      Colors.grey,
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      child: OutlinedButton(
          // style:
          // ButtonStyle(backgroundColor :
          // getRandomElement(colors)),
          child: Text(title),
          onPressed: () {
            Get.to(widget);
          }),
    );
  }
}

T getRandomElement<T>(List<T> list) {
  var i = Random().nextInt(list.length);
  return list[i];
}
