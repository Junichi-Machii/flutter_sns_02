import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/details/card_container.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/views/comments/conponents/comment_like_button.dart';
import 'package:http/http.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    required this.mainModel,
    required this.commentsModel,
    required this.commentDoc,
    required this.post,
  });
  final DocumentSnapshot<Map<String, dynamic>> commentDoc;
  final CommentsModel commentsModel;
  final Post post;
  final Comment comment;
  final MainModel mainModel;
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      borderColor: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserImage(
                length: 54,
                userImageURL: comment.uid == mainModel.firestoreUser.uid
                    ? mainModel.firestoreUser.userImageURL
                    : comment.userImageURL),
            Text(
              comment.comment,
              style: TextStyle(fontSize: 24),
            ),
            Column(
              children: [
                IconButton(icon: Icon(Icons.comment), onPressed: () {}),
                SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    CommentLikeButton(
                      commentsModel: commentsModel,
                      commentDoc: commentDoc,
                      mainModel: mainModel,
                      comment: comment,
                      post: post,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(comment.likeCount.toString())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
