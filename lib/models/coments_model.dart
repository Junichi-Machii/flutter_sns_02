import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/voids.dart' as voids;
import 'package:flutter_sns_u_02/models/main_model.dart';

final commentsProvider = ChangeNotifierProvider((ref) => CommentsModel());

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String comment = "";

  void showCommentDialog(
      {required BuildContext context, required MainModel mainModel}) {
    voids.showFlashDialog(
      context: context,
      mainModel: mainModel,
      textEditingController: textEditingController,
      onChanged: (value) => comment = value,
      titleString: "Comments",
      indicatorColor: Colors.black87,
      barrierColor: const Color.fromARGB(255, 125, 150, 163).withOpacity(0.5),
      builder: (context, controller) => FlashBar(
        controller: controller,
        clipBehavior: Clip.antiAlias,
        indicatorColor: Colors.red,
        icon: Icon(Icons.tips_and_updates_outlined),
        title: Text('Comment'),
        content: Form(
          child: TextField(
            controller: textEditingController,
            onChanged: (value) => comment = value,
            maxLength: 100,
          ),
        ),
        primaryAction: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  await createComment(context: context, mainModel: mainModel);
                  await controller.dismiss();
                  comment = "";
                  textEditingController.text = "";
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

  Future<void> createComment(
      {required BuildContext context, required mainModel}) async {}
}
