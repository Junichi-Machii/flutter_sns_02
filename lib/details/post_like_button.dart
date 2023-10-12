import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/posts_model.dart';

class PostLikeButton extends StatelessWidget {
  const PostLikeButton({
    super.key,
    required this.mainModel,
    required this.post,
    required this.postsModel,
    required this.postDoc,
  });
  final PostsModel postsModel;
  final MainModel mainModel;
  final Post post;
  final DocumentSnapshot<Map<String, dynamic>> postDoc;
  @override
  Widget build(BuildContext context) {
    final isLike = mainModel.likePostIds.contains(post.postId);
    final int plusOneCount = post.likeCount + 1;

    return Row(
      children: [
        Container(
          child: isLike
              ? InkWell(
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () async => await postsModel.unLike(
                    postRef: postDoc.reference,
                    postDoc: postDoc,
                    post: post,
                    mainModel: mainModel,
                  ),
                )
              : InkWell(
                  child: const Icon(
                    Icons.favorite_border,
                  ),
                  onTap: () async => await postsModel.like(
                    postRef: postDoc.reference,
                    postDoc: postDoc,
                    post: post,
                    mainModel: mainModel,
                  ),
                ),
        ),
        const SizedBox(width: 8),
        Text(isLike ? plusOneCount.toString() : post.likeCount.toString())
      ],
    );
  }
}
