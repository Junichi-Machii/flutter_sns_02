import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

//package
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createPostProvider = ChangeNotifierProvider((ref) => CreatePostModel());

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();

  String text = "";

  void showPostDialog({required BuildContext context}) {
    context.showFlash<String>(
      persistent: true,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      builder: (context, controller) => FlashBar(
        controller: controller,
        clipBehavior: Clip.antiAlias,
        indicatorColor: Colors.red,
        icon: Icon(Icons.tips_and_updates_outlined),
        title: Text('Post Title'),
        content: Form(
          child: TextField(
            controller: textEditingController,
            onChanged: (value) => text = value,
            autofocus: true,
            maxLength: 14,
          ),
        ),
        primaryAction: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                } else {
                  await controller.dismiss();
                }
              },
              icon: Icon(Icons.send),
            ),
            IconButton(
              onPressed: () async {
                return await controller.dismiss();
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
