import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

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
    return Scaffold();
  }
}
