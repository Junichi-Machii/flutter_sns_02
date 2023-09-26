import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//constans
import 'package:flutter_sns_u_02/constants/others.dart';

//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/follower/follower.dart';
import 'package:flutter_sns_u_02/domain/following_token/following_token.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final passiveUserProfileProvider =
    ChangeNotifierProvider((ref) => PassiveUserProfileModel());

class PassiveUserProfileModel extends ChangeNotifier {
  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.add(passiveUser.uid);
    notifyListeners();
    final Timestamp now = Timestamp.now();
    //following
    final String tokenId = returnUuidV4();
    final FollowingToken followingToken = FollowingToken(
      createdAt: now,
      passiveUid: passiveUser.uid,
      tokenId: tokenId,
    );
    final FirestoreUser activeUser = mainModel.firestoreUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .doc(tokenId)
        .set(
          followingToken.toJson(),
        );
    //follower
    final Follower follower = Follower(
        createdAt: now,
        followedUid: passiveUser.uid,
        followerUid: activeUser.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .set(follower.toJson());
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveUser}) async {
    mainModel.followingUids.remove(passiveUser.uid);
    notifyListeners();
    //followしているTokenを取得する
    final FirestoreUser activeUser = mainModel.firestoreUser;

    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .where("passiveUid", isEqualTo: passiveUser.uid)
        .get();
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    await token.reference.delete();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .delete();
  }
}
