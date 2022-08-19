import 'dart:convert';

import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:web_socket/view/messenger/controller/chat_controller.dart';

class ChatApp extends StatelessWidget {
  ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  ChatPage({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  // List<types.Message> _messages = [];
  // final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  @override
  void initState() {
    Get.put(ChatController());
  }

  void _handleAtachmentPressed() {
    Get.bottomSheet(SafeArea(
      child: SizedBox(
        height: 144,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                _handleImageSelection();
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('Photo'),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                _handleFileSelection();
              },
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('File'),
              ),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _handleFileSelection() async {
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
    // if (result != null) {
    //   print(result.path);
    //   final bytes = await result.readAsBytes();
    //   messageController.sendMessage(data: bytes);

    // if (result != null && result.path != null) {
    //   final message = types.FileMessage(
    //       author: _user,
    //       createdAt: DateTime.now().millisecondsSinceEpoch,
    //       id: '123-cena',
    //       name: file.fileName,
    //       size: 100,
    //       uri: result.uri.path);

    //   _addMessage(message);
    // }
  }

  void _handleImageSelection() async {
    final file = OpenFilePicker()
      ..filterSpecification = {
        'Image': '*.jpeg;*.png',
        // 'Word Document (*.doc)': '*.doc',
        // 'Web Page (*.htm; *.html)': '*.htm;*.html',
        // 'Text Document (*.txt)': '*.txt',
        // 'All Files': '*.*'
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'doc'
      ..title = 'Select a document';

    final result = file.getFile();

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      //     final message = types.ImageMessage(
      //       author: _user,
      //       createdAt: DateTime.now().millisecondsSinceEpoch,
      //       height: image.height.toDouble(),
      //       id: '123-cena',
      //       name: file.fileName,
      //       size: bytes.length,
      //       uri: result.path,
      //       width: image.width.toDouble(),
      //     );

      //     _addMessage(message);
    }
  }

  // void _handleMessageTap(BuildContext context, types.Message message) async {
  //   if (message is types.FileMessage) {
  //     // await OpenFile.open(message.uri);
  //   }
  // }

  // void _handlePreviewDataFetched(
  //   types.TextMessage message,
  //   types.PreviewData previewData,
  // ) {
  //   final index = _messages.indexWhere((element) => element.id == message.id);
  //   final updatedMessage = _messages[index].copyWith(previewData: previewData);

  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     setState(() {
  //       _messages[index] = updatedMessage;
  //     });
  //   });
  // }

  // void _handleSendPressed( message) {
  //   final textMessage = types.TextMessage(
  //     author: _user,
  //     createdAt: DateTime.now().millisecondsSinceEpoch,
  //     id: '123-cena',
  //     text: message.text,
  //   );
  //   final messageController = Get.put(MessagerController());
  //   messageController.sendMessage(
  //       data: json.encode(
  //           {'sender': 'cena', 'receiver': 'nima', 'text': message.text}));
  // }

  // void _loadMessages() async {
  //   final response = await rootBundle.loadString('assets/messages.json');
  //   final messages = (jsonDecode(response) as List)
  //       .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   setState(() {
  //     _messages = messages;
  //   });
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: Chat(
//       //   messages: _messages,
//       //   onAttachmentPressed: _handleAtachmentPressed,
//       //   // onMessageTap: _handleMessageTap,
//       //   onPreviewDataFetched: _handlePreviewDataFetched,
//       //   onSendPressed: _handleSendPressed,
//       //   user: _user,
//       // ),

//       body: Container(
//         child: Center(child: Text("Chat")),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.grey.shade600,
//         selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//         unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             title: Text("Chats"),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.group_work),
//             title: Text("Channels"),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_box),
//             title: Text("Profile"),
//           ),
//         ],
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 130 : 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected
                        ? item.activeColor.withOpacity(1)
                        : item.inactiveColor == null
                            ? item.activeColor
                            : item.inactiveColor,
                  ),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                          color: item.activeColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}
