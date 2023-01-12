import 'dart:typed_data';

import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket/view/echoImage/controller/message_controller.dart';
import 'package:web_socket/view/message/widget/message_widget.dart';
import 'package:get/get.dart';
import 'package:web_socket/view/message/controller/message_controller.dart';

class ImageView extends StatelessWidget {
  final String title;
  ImageView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageController = Get.put(ImageController());

    return Scaffold(
      key: imageController.scaffoldKey,
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder(
                    stream: imageController.channel!.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is List<int>) {
                          // print(snapshot.data);
                          // final ByteData imageData = snapshot.data as ByteData;
                          // final Uint8List bytes = imageData.buffer.asUint8List();
                          final Uint8List bytes =
                              Uint8List.fromList(snapshot.data as List<int>);
                          // display it with the Image.memory widget
                          return Image.memory(bytes);
                        }
                        return Container();
                      } else {
                        return Container();
                      }
                    }),
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
                        imageController.sendImage(data: bytes);
                      }
                    },
                    child: Text("Pick a File")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
