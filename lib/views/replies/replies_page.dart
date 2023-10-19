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
    return Scaffold(
      appBar: AppBar(
        title: Text("Reply"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: commentDoc.reference
            .collection("postCommentReplies")
            .orderBy("likeCount", descending: true)
            .limit(30)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) const Text("Error: ");
          if (snapshot.connectionState == ConnectionState.waiting)
            const Text("Waiting");
          final repliesDocs = snapshot.data!.docs;

          return ListView(
            // DocumentSnapshot<Map<String, dynamic>>と定義するのは不可
            children: repliesDocs.map((DocumentSnapshot replyDoc) {
              final Map<String, dynamic> data =
                  replyDoc.data()! as Map<String, dynamic>;
              final Reply reply = Reply.fromJson(data);
              return ReplyCard(
                  comment: comment,
                  mainModel: mainModel,
                  repliesModel: repliesModel,
                  replyDoc: replyDoc,
                  reply: reply);
            }).toList(),
          );
        },
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
