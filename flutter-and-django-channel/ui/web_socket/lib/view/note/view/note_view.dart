import 'dart:typed_data';

import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket/view/note/controller/message_controller.dart';

class NoteView extends StatelessWidget {
  final String title;
  NoteView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteController = Get.put(NoteController());
    noteController.get_notes();
    return Scaffold(
      key: noteController.scaffoldKey,
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Obx(
          () {
            return noteController.notes.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: noteController.notes.value.length,
                    itemBuilder: (context, index) {
                      final note = noteController.notes.value[index];
                      return Card(
                        child: ListTile(
                          title: Text(note.title ?? "No title"),
                          subtitle: Text(note.text ?? "No text"),
                        ),
                      );
                    });
          },
        )),
      ),
    );
  }
}
