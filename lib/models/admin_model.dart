import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/others.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';

final adminProvider = ChangeNotifierProvider((ref) => AdminModel());

class AdminModel extends ChangeNotifier {
  Future<void> admin(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required FirestoreUser firestoreUser}) async {
    // 管理者ができる処理

    //user email deletion
    // final WriteBatch batch = FirebaseFirestore.instance.batch();
    // final usersQshot =
    //     await FirebaseFirestore.instance.collection("users").get();
    // for (final user in usersQshot.docs) {
    //   batch.update(user.reference, {
    //     "email": FieldValue.delete(),
    //   });
    // }

    // // post に　userName userImageURL  追加
    // final postsQshot = await currentUserDoc.reference.collection("posts").get();
    // for (final post in postsQshot.docs) {
    //   batch.update(post.reference, {
    //     "userName": firestoreUser.userName,
    //     "userImageURL": firestoreUser.userImageURL,
    //   });
    // }
    //   WriteBatch batch = FirebaseFirestore.instance.batch();
    //   final String activeUid = returnAuthUser()!.uid;
    //   for (int i = 0; i <= 1; i++) {
    //     final Timestamp now = Timestamp.now();
    //     final String postId = returnUuidV4();
    //     final Post post = Post(
    //       createdAt: now,
    //       updatedAt: now,
    //       hashTags: [],
    //       imageURL: "",
    //       likeCount: 0,
    //       postId: postId,
    //       text: i.toString(),
    //       uid: activeUid,
    //     );
    //     final DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore
    //         .instance
    //         .collection("users")
    //         .doc(activeUid)
    //         .collection("posts")
    //         .doc(postId);
    //     batch.set(ref, post.toJson());
    //   }
    // await batch.commit();
  }
}
