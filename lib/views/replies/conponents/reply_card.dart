import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_sns_u_02/details/card_container.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/comment/comment.dart';
import 'package:flutter_sns_u_02/domain/reply/reply.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/replies_model.dart';
import 'package:flutter_sns_u_02/views/replies/conponents/reply_like_button.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({
    super.key,
    required this.comment,
    required this.mainModel,
    required this.repliesModel,
    required this.replyDoc,
    required this.reply,
  });
  final DocumentSnapshot replyDoc;
  final RepliesModel repliesModel;
  final Reply reply;
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
            Column(
              children: [
                UserImage(
                    length: 54,
                    userImageURL: reply.uid == mainModel.firestoreUser.uid
                        ? mainModel.firestoreUser.userImageURL
                        : reply.userImageURL),
                Text(reply.userName),
              ],
            ),
            Text(
              reply.reply,
              style: TextStyle(fontSize: 24, overflow: TextOverflow.ellipsis),
            ),
            ReplyLikeButton(
                mainModel: mainModel,
                comment: comment,
                repliesModel: repliesModel,
                replyDoc: replyDoc,
                reply: reply),
          ],
        ),
      ),
    );
  }
}
