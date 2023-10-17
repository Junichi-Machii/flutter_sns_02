import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/reply/reply.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/replies_model.dart';

class ReplyLikeButton extends StatelessWidget {
  const ReplyLikeButton({
    super.key,
    required this.mainModel,
    required this.comment,
    required this.repliesModel,
    required this.replyDoc,
    required this.reply,
    // required this.commentDoc,
  });
  final DocumentSnapshot<Map<String, dynamic>> replyDoc;
  final RepliesModel repliesModel;
  final Reply reply;
  final MainModel mainModel;
  final Comment comment;
  // final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  @override
  Widget build(BuildContext context) {
    final bool isRepliesLike =
        mainModel.likeRepliesIds.contains(reply.postCommentReplyId);
    final int likeReplyCount = reply.likeCount + 1;
    return Row(
      children: [
        Container(
          child: isRepliesLike
              ? InkWell(
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () async => await repliesModel.unLike(
                      replyDoc: replyDoc,
                      mainModel: mainModel,
                      comment: comment,
                      reply: reply),
                )
              : InkWell(
                  child: const Icon(
                    Icons.favorite_border,
                  ),
                  onTap: () async => await repliesModel.like(
                    replyDoc: replyDoc,
                    mainModel: mainModel,
                    comment: comment,
                    reply: reply,
                  ),
                ),
        ),
        const SizedBox(width: 8),
        Text(
          isRepliesLike
              ? likeReplyCount.toString()
              : reply.likeCount.toString(),
        ),
      ],
    );
  }
}
