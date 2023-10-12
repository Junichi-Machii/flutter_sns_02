import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/details/card_container.dart';
import 'package:flutter_sns_u_02/details/post_like_button.dart';
import 'package:flutter_sns_u_02/details/user_image.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/coments_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.mainModel,
    required this.commentsModel,
    required this.postDoc,
    required this.postsModel,
  });

  final Post post;
  final MainModel mainModel;
  final CommentsModel commentsModel;
  final PostsModel postsModel;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
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
                userImageURL: post.uid == mainModel.firestoreUser.uid
                    ? mainModel.firestoreUser.userImageURL
                    : post.imageURL),
            Text(
              post.text,
              style: TextStyle(fontSize: 24),
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.comment),
                  onPressed: () async => await commentsModel.init(
                      context: context,
                      mainModel: mainModel,
                      postDoc: postDoc,
                      post: post),
                ),
                SizedBox(height: 18),
                PostLikeButton(
                    mainModel: mainModel,
                    post: post,
                    postsModel: postsModel,
                    postDoc: postDoc),
              ],
            )
          ],
        ),
      ),
    );
  }
}
