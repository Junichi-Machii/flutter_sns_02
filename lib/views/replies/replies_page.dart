import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/reply/reply.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/replies_model.dart';
import 'package:flutter_sns_u_02/views/refresh_screen.dart';
import 'package:flutter_sns_u_02/views/reload_screen.dart';
import 'package:flutter_sns_u_02/views/replies/conponents/reply_card.dart';

class RepliesPage extends ConsumerWidget {
  const RepliesPage({
    super.key,
    required this.commentDoc,
    required this.comment,
    required this.mainModel,
  });

  final Comment comment;
  final MainModel mainModel;

  final DocumentSnapshot<Map<String, dynamic>> commentDoc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RepliesModel repliesModel = ref.watch(repliesProvider);
    final repliesDocs = repliesModel.repliesDocs;
    return Scaffold(
      appBar: AppBar(
        title: Text("Reply"),
      ),
      body: repliesDocs.isEmpty
          ? ReloadScreen(
              onReload: () async =>
                  await repliesModel.onReload(commentDoc: commentDoc))
          : RefreshScreen(
              refreshController: repliesModel.refreshController,
              onLoading: () async =>
                  await repliesModel.onLoading(commentDoc: commentDoc),
              onRefresh: () async =>
                  await repliesModel.onRefresh(commentDoc: commentDoc),
              child: ListView.builder(
                itemCount: repliesDocs.length,
                itemBuilder: (context, index) {
                  final repliesDoc = repliesDocs[index];
                  final Reply reply = Reply.fromJson(repliesDoc.data()!);
                  return ReplyCard(
                      replyDoc: commentDoc,
                      comment: comment,
                      mainModel: mainModel,
                      repliesModel: repliesModel,
                      reply: reply);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          child: const Icon(Icons.comment_outlined),
          onPressed: () => repliesModel.showRepliesDialog(
              comment: comment,
              context: context,
              mainModel: mainModel,
              commentDoc: commentDoc)),
    );
  }
}
