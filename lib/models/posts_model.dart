import 'package:flutter/material.dart';

//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
//constants
import 'package:flutter_sns_u_02/constants/strings.dart';
//domains
import 'package:flutter_sns_u_02/domain/like_post_token/like_post_token.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/domain/post_like/post_like.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

final postsProvider = ChangeNotifierProvider((ref) => PostsModel());

class PostsModel extends ChangeNotifier {
  Future<void> like(
      {required DocumentReference<Map<String, dynamic>> postRef,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required Post post,
      required MainModel mainModel}) async {
    //setting
    final String postId = post.postId;
    mainModel.likePostIds.add(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;
    final String passiveUid = post.uid;
    notifyListeners();

    //自分がいいねした印
    final LikePostToken likePostToken = LikePostToken(
      createdAt: now,
      activeUid: activeUid,
      passiveUid: passiveUid,
      postRef: postRef,
      postId: postId,
      tokenId: tokenId,
      tokenType: likePostTokenTypeString,
    );
    await currentUserDoc.reference
        .collection("tokens")
        .doc(tokenId)
        .set(likePostToken.toJson());

    //投稿がいいねされた時の印
    final PostLike postLike = PostLike(
        activeUid: activeUid,
        createdAt: now,
        postCreatorUid: passiveUid,
        postId: postId,
        postRef: postRef);
    //いいねする人が重複しないようにUidをdocumentIdとする
    await postDoc.reference
        .collection("postLikes")
        .doc(activeUid)
        .set(postLike.toJson());
  }

  Future<void> unLike(
      {required DocumentReference<Map<String, dynamic>> postRef,
      required DocumentSnapshot<Map<String, dynamic>> postDoc,
      required Post post,
      required MainModel mainModel}) async {
    //setting
    final String postId = post.postId;
    mainModel.likePostIds.remove(postId);
    final currentUserDoc = mainModel.currentUserDoc;
    final String activeUid = currentUserDoc.id;
    notifyListeners();

    //自分がいいねした印を削除
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUid)
        .collection("tokens")
        .where("postId", isEqualTo: postId)
        .get();
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    await token.reference.delete();

    //投稿がいいねされた時の印を削除
    await postDoc.reference.collection("postLikes").doc(activeUid).delete();
  }
}
