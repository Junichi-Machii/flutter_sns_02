import 'package:flutter/material.dart';
//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/constants/voids.dart' as voids;
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

final commentsProvider = ChangeNotifierProvider((ref) => CommentsModel());

class CommentsModel extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();
  String commentString = "";
  List<DocumentSnapshot<Map<String, dynamic>>> commentDocs = [];
  bool isLoading = false;
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) {
    return postDoc.reference
        .collection("postComments")
        .orderBy("likeCount", descending: true);
  }

//コメントボタンが押された時の処理
  Future<void> init({
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required BuildContext context,
    required MainModel mainModel,
    required Post post,
  }) async {
    routes.toCommentsPage(
        context: context, mainModel: mainModel, postDoc: postDoc, post: post);
    await onReload(postDoc: postDoc);
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    await Future<void>.delayed(const Duration(seconds: 3));
    // if failed,use refreshFailed()
    // refreshController.refreshCompleted();
    if (commentDocs.isNotEmpty) {
      final qshot = await returnQuery(postDoc: postDoc)
          .endBeforeDocument(commentDocs.first)
          .get();
      final reversed = qshot.docs.reversed.toList();
      for (final commentDoc in reversed) {
        commentDocs.insert(0, commentDoc);
      }
    }
    notifyListeners();
  }

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    startLoading();
    final qshot = await returnQuery(postDoc: postDoc).get();
    commentDocs = qshot.docs;

    endLoading();
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    // refreshController.loadComplete();
    if (commentDocs.isNotEmpty) {
      final qshot = await returnQuery(postDoc: postDoc)
          .startAfterDocument(commentDocs.last)
          .get();
      for (final commentDoc in qshot.docs) {
        commentDocs.add(commentDoc);
      }
    }
    notifyListeners();
  }

  void showCommentDialog(
      {required BuildContext context,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> postDoc}) {
    voids.showFlashDialog(
      context: context,
      mainModel: mainModel,
      textEditingController: textEditingController,
      onChanged: (value) => commentString = value,
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
            onChanged: (value) => commentString = value,
            maxLength: 100,
          ),
        ),
        primaryAction: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  await createComment(
                      currentUserDoc: mainModel.currentUserDoc,
                      firestoreUser: mainModel.firestoreUser,
                      postDoc: postDoc);
                  await controller.dismiss();
                  commentString = "";
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
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser,
      required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postCommentId = returnUuidV4();
    final Comment comment = Comment(
      createdAt: now,
      postCommentReplyCount: 0,
      likeCount: 0,
      comment: commentString,
      userName: firestoreUser.userName,
      userImageURL: "",
      uid: activeUid,
      postCommentId: postCommentId,
    );
    await postDoc.reference
        .collection("postComments")
        .doc(postCommentId)
        .set(comment.toJson());
  }
}
