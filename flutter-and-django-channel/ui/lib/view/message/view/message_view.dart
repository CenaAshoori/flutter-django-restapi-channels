import 'dart:typed_data';

import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket/view/message/controller/message_controller.dart';
import 'package:web_socket/view/message/widget/message_widget.dart';
import 'package:get/get.dart';
import 'package:web_socket/view/message/controller/message_controller.dart';

class MessageView extends StatelessWidget {
  final String title;
  MessageView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = Get.put(MessageController());

    return Scaffold(
      key: messageController.scaffoldKey,
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: messageController.textController,
            ),
            StreamBuilder(
                stream: messageController.channel!.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('${snapshot.data}');
                  } else {
                    return Container();
                  }
                }),
            OutlinedButton(
                onPressed: () {
                  messageController.sendMessage();
                },
                child: Text("Send")),
            OutlinedButton(
                onPressed: () async {
                  final file = OpenFilePicker()
                    ..filterSpecification = {
                      'Image': '*.jpeg;*.png',
                      'Word Document (*.doc)': '*.doc',
                      'Web Page (*.htm; *.html)': '*.htm;*.html',
                      'Text Document (*.txt)': '*.txt',
                      'All Files': '*.*'
                    }
                    ..defaultFilterIndex = 0
                    ..defaultExtension = 'doc'
                    ..title = 'Select a document';

                  final result = file.getFile();
                  if (result != null) {
                    print(result.path);
                    final bytes = await result.readAsBytes();
                    messageController.sendMessage(data: bytes);
                  }
                },
                child: Text("Pick a File")),
          ],
        ),
      ),
    );
  }
}
