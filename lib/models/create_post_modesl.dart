import 'package:flutter/material.dart';

//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash_helper.dart';
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//constants
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
//domain
import 'package:flutter_sns_u_02/domain/post/post.dart';
//model
import 'package:flutter_sns_u_02/models/main_model.dart';

final createPostProvider = ChangeNotifierProvider((ref) => CreatePostModel());

class CreatePostModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();

  String text = "";

  void showPostDialog({
    required BuildContext context,
    required MainModel mainModel,
  }) {
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
            maxLength: 15,
          ),
        ),
        primaryAction: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  await createPost(mainModel: mainModel);
                  await controller.dismiss();
                  text = "";
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

  Future<void> createPost({
    required MainModel mainModel,
  }) async {
    final Timestamp now = Timestamp.now();
    final DocumentSnapshot<Map<String, dynamic>> currentUserDoc =
        mainModel.currentUserDoc;
    final FirestoreUser firestoreUser = mainModel.firestoreUser;
    final String activeUid = currentUserDoc.id;
    final String postId = returnUuidV4();
    final Post post = Post(
      createdAt: now,
      updatedAt: now,
      hashTags: [],
      imageURL: "",
      userImageURL: firestoreUser.userImageURL,
      userName: firestoreUser.userName,
      likeCount: 0,
      postId: postId,
      commentCount: 0,
      text: text,
      uid: activeUid,
    );
    await currentUserDoc.reference
        .collection("posts")
        .doc(postId)
        .set(post.toJson());
  }
}
