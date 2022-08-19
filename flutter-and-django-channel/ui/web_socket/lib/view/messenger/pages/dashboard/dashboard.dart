import 'package:get/get.dart';
import 'package:web_socket/view/messenger/controller/chat_controller.dart';
import 'package:web_socket/view/messenger/navigation/navigation_bottom_bar.dart';

import '../../pages/add/add_page.dart';
import '../../pages/home/home_page.dart';
import '../../pages/messages/messages_page.dart';
import '../../pages/users/users_page.dart';
import 'package:flutter/material.dart';

class MyDashBoard extends GetView<ChatController> {
  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    // return GetBuilder<ChatController>(builder: (controller) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.bottomIndex.value,
            children: [
              HomePage(),
              UsersPage(),
              MessagesPage(),
              AddPage(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }
  // );
  // }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: controller.bottomIndex.value,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => controller..bottomIndex(index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.message),
          title: Text(
            'Messages ',
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
