import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/views/comments/conponents/comment_card.dart';
import 'package:flutter_sns_u_02/views/refresh_screen.dart';
import 'package:flutter_sns_u_02/views/reload_screen.dart';

class CommentsPage extends ConsumerWidget {
  const CommentsPage(
      {super.key,
      required this.mainModel,
      required this.postDoc,
      required this.post});

  final MainModel mainModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  final Post post;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final CommentsModel commentsModel = ref.watch(commentsProvider);
    final commentDocs = commentsModel.commentDocs;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: commentDocs.isEmpty
          ? ReloadScreen(
              onReload: () => commentsModel.onReload(postDoc: postDoc))
          : RefreshScreen(
              onRefresh: () => commentsModel.onRefresh(postDoc: postDoc),
              child: ListView.builder(
                itemCount: commentDocs.length,
                itemBuilder: (context, index) {
                  final commentDoc = commentDocs[index];
                  final Comment comment = Comment.fromJson(commentDoc.data()!);
                  return CommentCard(
                      comment: comment,
                      mainModel: mainModel,
                      commentsModel: commentsModel,
                      commentDoc: commentDoc,
                      post: post);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Icon(Icons.comment_outlined),
          onPressed: () => commentsModel.showCommentDialog(
              context: context, mainModel: mainModel, postDoc: postDoc)),
    );
  }
}
