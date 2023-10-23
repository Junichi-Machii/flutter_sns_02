import 'package:flutter/material.dart';
//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/flash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';

import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/constants/voids.dart' as voids;
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/comment_like/comment_like.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/like_comment_token/like_comment_token.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/mute_user_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final commentsProvider = ChangeNotifierProvider((ref) => CommentsModel());

class CommentsModel extends ChangeNotifier {
  RefreshController refreshController = RefreshController();
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

// 同じデータを取得しないようにする。
  String indexPostId = "";

//コメントボタンが押された時の処理
  Future<void> init({
    required DocumentSnapshot<Map<String, dynamic>> postDoc,
    required BuildContext context,
    required MainModel mainModel,
    required Post post,
  }) async {
    refreshController = RefreshController();
    routes.toCommentsPage(
        context: context, mainModel: mainModel, postDoc: postDoc, post: post);
    final postId = post.postId;
    if (indexPostId != postId) {
      await onReload(postDoc: postDoc);
    }
    indexPostId = postId;
    // indexPostId = postDoc.id;
  }

  // void startLoading() {
  //   isLoading = true;
  //   notifyListeners();
  // }

  // void endLoading() {
  //   isLoading = false;
  //   notifyListeners();
  // }

  Future<void> onRefresh(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        docs: commentDocs, query: returnQuery(postDoc: postDoc));
    notifyListeners();
  }

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    await voids.processBasicDocs(
        docs: commentDocs, query: returnQuery(postDoc: postDoc));

    notifyListeners();
  }

  Future<void> onLoading(
      {required DocumentSnapshot<Map<String, dynamic>> postDoc}) async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        docs: commentDocs, query: returnQuery(postDoc: postDoc));
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
      postRef: postDoc.reference,
      createdAt: now,
      postCommentReplyCount: 0,
      likeCount: 0,
      comment: commentString,
      userName: firestoreUser.userName,
      userImageURL: firestoreUser.userImageURL,
      uid: activeUid,
      postCommentId: postCommentId,
    );
    await postDoc.reference
        .collection("postComments")
        .doc(postCommentId)
        .set(comment.toJson());
    notifyListeners();
  }

  Future<void> like({
    required DocumentReference<Map<String, dynamic>> commentRef,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required MainModel mainModel,
    required Comment comment,
    required Post post,
  }) async {
    //setting
    final String postCommentId = comment.postCommentId;
    mainModel.likeCommentIds.add(postCommentId);

    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = comment.uid;
    final LikeCommentToken likeCommentToken = LikeCommentToken(
      createdAt: now,
      activeUid: activeUid,
      passiveUid: passiveUid,
      commentRef: commentDoc.reference,
      postCommentId: postCommentId,
      tokenId: tokenId,
      tokenType: likeCommentTokenTypeString,
    );
    mainModel.likeCommentTokens.add(likeCommentToken);
    notifyListeners();

    //自分がコメントにいいねした印
    await currentUserDoc.reference
        .collection("tokens")
        .doc(tokenId)
        .set(likeCommentToken.toJson());

    //コメントがいいねされた時の印
    final CommentLike commentLike = CommentLike(
        activeUid: activeUid,
        createdAt: now,
        postCommentCreatorUid: comment.uid,
        postCommentId: postCommentId,
        postCommentRef: commentDoc.reference);
    //いいねする人が重複しないようにUidをdocumentIdとする
    await commentDoc.reference
        .collection("postCommentLikes")
        .doc(activeUid)
        .set(commentLike.toJson());
  }

  Future<void> unLike({
    required DocumentReference<Map<String, dynamic>> commentRef,
    required DocumentSnapshot<Map<String, dynamic>> commentDoc,
    required MainModel mainModel,
    required Comment comment,
    required Post post,
  }) async {
    final String postCommentId = comment.postCommentId;
    mainModel.likeCommentIds.remove(postCommentId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    final deleteLikeCommentToken = mainModel.likeCommentTokens
        .where((element) => element.postCommentId == postCommentId)
        .toList()
        .first;
    mainModel.likeCommentTokens.remove(deleteLikeCommentToken);
    notifyListeners();

    await currentUserDoc.reference
        .collection("tokens")
        .doc(deleteLikeCommentToken.tokenId)
        .delete();

    //投稿がいいねされた時の印を削除
    // await commentDoc.reference
    //     .collection("postCommentLikes")
    //     .doc(activeUid)
    //     .delete();

    final DocumentReference<Map<String, dynamic>> postCommentRef =
        deleteLikeCommentToken.commentRef;

    await postCommentRef.collection("postCommentLikes").doc(activeUid).delete();
  }
}
