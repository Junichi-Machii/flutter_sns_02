import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

import 'package:flutter_sns_u_02/constants/voids.dart' as voids;

import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/like_reply_token/like_reply_token.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/domain/reply/reply.dart';
import 'package:flutter_sns_u_02/domain/reply_like/reply_like.dart';
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

  Future<void> like({
    required DocumentSnapshot<Map<String, dynamic>> replyDoc,
    required MainModel mainModel,
    required Comment comment,
    required Reply reply,
  }) async {
    //setting
    final String postCommentReplyId = reply.postCommentReplyId;
    mainModel.likeRepliesIds.add(postCommentReplyId);

    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = comment.uid;
    final DocumentReference<Map<String, dynamic>> postCommentReplyRef =
        replyDoc.reference;
    final LikeReplyToken likeReplyToken = LikeReplyToken(
        createdAt: now,
        activeUid: activeUid,
        passiveUid: passiveUid,
        postCommentReplyRef: postCommentReplyRef,
        postCommentReplyId: postCommentReplyId,
        tokenId: tokenId,
        tokenType: likeReplyTokenTypeString);
    mainModel.likeReplyTokens.add(likeReplyToken);
    notifyListeners();

    //自分がコメントにいいねした印
    await currentUserDoc.reference
        .collection("tokens")
        .doc(tokenId)
        .set(likeReplyToken.toJson());

    //コメントがいいねされた時の印
    final ReplyLike replyLike = ReplyLike(
        activeUid: activeUid,
        createdAt: now,
        postCommentReplyCreatorUid: reply.uid,
        postCommentReplyId: postCommentReplyId,
        postCommentReplyRef: postCommentReplyRef);
    //いいねする人が重複しないようにUidをdocumentIdとする
    await postCommentReplyRef
        .collection("postCommentReplyLikes")
        .doc(activeUid)
        .set(replyLike.toJson());
  }

  Future<void> unLike({
    required DocumentSnapshot<Map<String, dynamic>> replyDoc,
    required MainModel mainModel,
    required Comment comment,
    required Reply reply,
  }) async {
    final String postCommentReplyId = reply.postCommentReplyId;
    mainModel.likeRepliesIds.remove(postCommentReplyId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteLikeReplyToken = mainModel.likeReplyTokens
        .where((element) => element.postCommentReplyId == postCommentReplyId)
        .toList()
        .first;
    mainModel.likeReplyTokens.remove(deleteLikeReplyToken);
    notifyListeners();
//自分がいいねした印を削除
    await currentUserDoc.reference
        .collection("tokens")
        .doc(deleteLikeReplyToken.tokenId)
        .delete();

    //投稿がいいねされた時の印を削除
    // await replyDoc.reference
    //     .collection("postCommentReplyLikes")
    //     .doc(activeUid)
    //     .delete();

    final DocumentReference<Map<String, dynamic>> postReplyRef =
        deleteLikeReplyToken.postCommentReplyRef;

    await postReplyRef
        .collection("postCommentReplyLikes")
        .doc(activeUid)
        .delete();
  }
}
