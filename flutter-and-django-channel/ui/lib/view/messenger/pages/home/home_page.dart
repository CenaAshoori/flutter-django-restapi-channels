import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket/view/messenger/controller/chat_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home page",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.accessibility_new),
              Text(
                "Home Page",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.defaultDialog(title: "HI", content: Text("Hey Fati"));
                  },
                  child: Text("Say Hi"))
            ],
          ),
        ),
      ),
    );
  }
}
