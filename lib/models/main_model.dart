import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/following_token/following_token.dart';
import 'package:flutter_sns_u_02/domain/like_comment_token/like_comment_token.dart';
import 'package:flutter_sns_u_02/domain/like_post_token/like_post_token.dart';

// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

//constants
import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/domain/like_reply_token/like_reply_token.dart';
import 'package:flutter_sns_u_02/domain/mute_user_token/mute_user_token.dart';

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
  List<LikeCommentToken> likeCommentTokens = [];
  List<String> likeCommentIds = [];
  List<LikeReplyToken> likeReplyTokens = [];
  List<String> likeRepliesIds = [];
  List<MuteUserToken> muteUserTokens = [];
  List<String> muteUserIds = [];

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
        case TokenType.likeComment:
          final LikeCommentToken likeCommentToken =
              LikeCommentToken.fromJson(tokenMap);
          likeCommentTokens.add(likeCommentToken);
          likeCommentIds.add(likeCommentToken.postCommentId);
          break;
        case TokenType.likeReply:
          final LikeReplyToken likeReplyToken =
              LikeReplyToken.fromJson(tokenMap);
          likeReplyTokens.add(likeReplyToken);
          likeRepliesIds.add(likeReplyToken.postCommentReplyId);
          break;
        case TokenType.muteUser:
          final MuteUserToken muteUserToken = MuteUserToken.fromJson(tokenMap);
          muteUserTokens.add(muteUserToken);
          muteUserIds.add(muteUserToken.passiveUid);
          break;
        case TokenType.mistake:
          break;
      }
    }
  }

  void updateFrontUserName({required String newUserName}) {
    firestoreUser = firestoreUser.copyWith(userName: newUserName);
    notifyListeners();
  }

  Future<void> logout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    routes.toLogInPage(context: context);
    notifyListeners();
  }
}
