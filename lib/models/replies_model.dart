import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

import 'package:flutter_sns_u_02/constants/voids.dart' as voids;

import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/domain/reply/reply.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_sns_u_02/constants/routes.dart' as routes;

final repliesProvider = ChangeNotifierProvider((ref) => RepliesModel());

class RepliesModel extends ChangeNotifier {
  RefreshController refreshController = RefreshController();
  final TextEditingController textEditingController = TextEditingController();
  String repliesString = "";
  List<DocumentSnapshot<Map<String, dynamic>>> repliesDocs = [];
  Query<Map<String, dynamic>> returnQuery(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) {
    return commentDoc.reference
        .collection("postCommentReplies")
        .orderBy("likeCount", descending: true);
  }

  // 同じデータを取得しないようにする。
  String indexPostCommentId = "";

  //コメントボタンが押された時の処理
  Future<void> init({
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required BuildContext context,
    required MainModel mainModel,
    required Comment comment,
    required Post post,
  }) async {
    refreshController = RefreshController();

    routes.toRepliesPage(
        context: context,
        mainModel: mainModel,
        commentDoc: commentDoc,
        comment: comment);
    final postCommentId = comment.postCommentId;
    if (indexPostCommentId != postCommentId) {
      await onReload(commentDoc: commentDoc);
    }
    indexPostCommentId = postCommentId;
    // indexPostId = commentDoc.id;
  }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    refreshController.refreshCompleted();
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // await Future<void>.delayed(const Duration(seconds: 3));
    // if failed,use refreshFailed()
    if (repliesDocs.isNotEmpty) {
      final qshot = await returnQuery(commentDoc: commentDoc)
          .endBeforeDocument(repliesDocs.first)
          .get();
      final reversed = qshot.docs.reversed.toList();
      for (final commentDoc in reversed) {
        repliesDocs.insert(0, commentDoc);
      }
    }
    notifyListeners();
  }

  Future<void> onReload({
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
  }) async {
    // startLoading();
    final qshot = await returnQuery(commentDoc: commentDoc).get();
    repliesDocs = qshot.docs;

    // endLoading();
    notifyListeners();
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    refreshController.loadComplete();
    if (repliesDocs.isNotEmpty) {
      final qshot = await returnQuery(commentDoc: commentDoc)
          .startAfterDocument(repliesDocs.last)
          .get();
      for (final commentDoc in qshot.docs) {
        repliesDocs.add(commentDoc);
      }
    }
    notifyListeners();
  }

  void showRepliesDialog(
      {required BuildContext context,
      required Comment comment,
      required MainModel mainModel,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc}) {
    voids.showFlashDialog(
      context: context,
      mainModel: mainModel,
      textEditingController: textEditingController,
      onChanged: (value) => repliesString = value,
      titleString: createReplyText,
      indicatorColor: Colors.black87,
      barrierColor: const Color.fromARGB(255, 125, 150, 163).withOpacity(0.5),
      builder: (context, controller) => FlashBar(
        controller: controller,
        clipBehavior: Clip.antiAlias,
        indicatorColor: Colors.red,
        icon: Icon(Icons.tips_and_updates_outlined),
        title: Text('Reply to'),
        content: Form(
          child: TextField(
            controller: textEditingController,
            onChanged: (value) => repliesString = value,
            maxLength: 100,
          ),
        ),
        primaryAction: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  await createReplies(
                      comment: comment,
                      currentUserDoc: mainModel.currentUserDoc,
                      firestoreUser: mainModel.firestoreUser,
                      commentDoc: commentDoc);
                  await controller.dismiss();
                  repliesString = "";
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

  Future<void> createReplies(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser,
      required DocumentSnapshot<Map<String, dynamic>> commentDoc,
      required Comment comment}) async {
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String postCommentReplyId = returnUuidV4();
    final Reply reply = Reply(
        createdAt: now,
        reply: repliesString,
        likeCount: 0,
        postRef: comment.postRef,
        postCommentRef: commentDoc.reference,
        postCommentReplyId: postCommentReplyId,
        userName: firestoreUser.userName,
        uid: activeUid,
        userImageURL: firestoreUser.userImageURL);
    await commentDoc.reference
        .collection("postCommentReplies")
        .doc(postCommentReplyId)
        .set(reply.toJson());
    notifyListeners();
  }
}
