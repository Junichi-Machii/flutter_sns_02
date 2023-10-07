import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Center(
        child: Text(
          "comment",
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.new_label),
        onPressed: () => commentsModel.showCommentDialog(
            context: context, mainModel: mainModel),
      ),
    );
  }
}
