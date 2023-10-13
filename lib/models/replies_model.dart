import 'package:flutter/material.dart';

//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
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

  Future<void> onReload(
      {required DocumentSnapshot<Map<String, dynamic>> commentDoc}) async {
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
}
