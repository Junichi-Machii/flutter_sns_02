import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/details/card_container.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/views/comments/conponents/comment_like_button.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    required this.mainModel,
    required this.commentsModel,
    required this.commentDoc,
    required this.post,
    required this.onTap,
  });
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final CommentsModel commentsModel;
  final Post post;
  final Comment comment;
  final MainModel mainModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      onTap: onTap,
      borderColor: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserImage(
                    length: 54,
                    userImageURL: comment.uid == mainModel.firestoreUser.uid
                        ? mainModel.firestoreUser.userImageURL
                        : comment.userImageURL),
                Text(comment.userName)
              ],
            ),
            Text(
              comment.comment,
              style: TextStyle(fontSize: 24),
            ),
            Column(
              children: [
                IconButton(
                    icon: Icon(Icons.reply),
                    onPressed: () => routes.toRepliesPage(
                        context: context,
                        mainModel: mainModel,
                        comment: comment,
                        commentDoc: commentDoc)),
                SizedBox(
                  height: 18,
                ),
                CommentLikeButton(
                  commentsModel: commentsModel,
                  commentDoc: commentDoc,
                  mainModel: mainModel,
                  comment: comment,
                  post: post,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
