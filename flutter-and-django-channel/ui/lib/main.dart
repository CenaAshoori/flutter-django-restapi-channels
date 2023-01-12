import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket/view/home/view/home_view.dart';
import 'package:web_socket/view/messenger/dashboard_binding.dart';

void main() {
  DashboardBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => MyHome(),
          binding: DashboardBinding(),
        )
      ],
      home: const MyHome(),
    );
  }
}
