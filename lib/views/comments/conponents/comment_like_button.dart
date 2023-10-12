import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

class CommentLikeButton extends StatelessWidget {
  const CommentLikeButton({
    super.key,
    required this.mainModel,
    required this.comment,
    required this.commentsModel,
    required this.commentDoc,
    required this.post,
    // required this.commentDoc,
  });
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final CommentsModel commentsModel;
  final Post post;
  final MainModel mainModel;
  final Comment comment;
  // final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  @override
  Widget build(BuildContext context) {
    final bool isCommentLike =
        mainModel.likeCommentIds.contains(comment.postCommentId);
    final int plusOneCount = comment.likeCount + 1;
    return Row(
      children: [
        Container(
          child: isCommentLike
              ? InkWell(
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () async => await commentsModel.unLike(
                    commentRef: commentDoc.reference,
                    commentDoc: commentDoc,
                    mainModel: mainModel,
                    comment: comment,
                    post: post,
                  ),
                )
              : InkWell(
                  child: const Icon(
                    Icons.favorite_border,
                  ),
                  onTap: () async => await commentsModel.like(
                      commentRef: commentDoc.reference,
                      commentDoc: commentDoc,
                      mainModel: mainModel,
                      comment: comment,
                      post: post),
                ),
        ),
        const SizedBox(width: 8),
        Text(
          isCommentLike
              ? plusOneCount.toString()
              : comment.likeCount.toString(),
        ),
      ],
    );
  }
}
