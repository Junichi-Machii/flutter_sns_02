import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/following_token/following_token.dart';
import 'package:flutter_sns_u_02/domain/like_post_token/like_post_token.dart';

// packages
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//constants
import 'package:flutter_sns_u_02/constants/routes.dart' as routes;

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;

  int counter = 0;

  late User? currentUser;
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;

  late FirestoreUser firestoreUser;

  //tokens
  List<FollowingToken> followingTokens = [];
  List<String> followingUids = [];
  List<LikePostToken> likePostTokens = [];
  List<String> likePostIds = [];

  // MainModelが起動した時の処理
  MainModel() {
    init();
  }
  Future<void> init() async {
    startLoading();
    currentUser = FirebaseAuth.instance.currentUser;
    currentUserDoc = await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .doc(currentUser!.uid)
        .get();
    await distributeTokens();
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    endLoading();
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> distributeTokens() async {
    final tokensQshot =
        await currentUserDoc.reference.collection("tokens").get();
    final tokenDocs = tokensQshot.docs;
    for (final token in tokenDocs) {
      final Map<String, dynamic> tokenMap = token.data();
      final TokenType tokenType = mapToTokenType(tokenMap: tokenMap);
      switch (tokenType) {
        case TokenType.following:
          final FollowingToken followingToken =
              FollowingToken.fromJson(tokenMap);
          followingTokens.add(followingToken);
          followingUids.add(followingToken.passiveUid);
          break;
        case TokenType.likePost:
          final LikePostToken likePostToken = LikePostToken.fromJson(tokenMap);
          likePostTokens.add(likePostToken);
          likePostIds.add(likePostToken.postId);
          break;
      }
    }
  }

  Future<void> logout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    routes.toLogInPage(context: context);
    notifyListeners();
  }
}
