import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
import 'package:flutter_sns_u_02/constants/others.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/mute_user_token/mute_user_token.dart';
import 'package:flutter_sns_u_02/domain/user_mute/user_mute.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

final muteUserProvider = ChangeNotifierProvider((ref) => MuteUserModel());

class MuteUserModel extends ChangeNotifier {
  Future<void> muteUser({
    required DocumentSnapshot<Map<String, dynamic>> passiveUserDoc,
    required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required MainModel mainModel,
  }) async {
    final tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String passiveUid = passiveUserDoc.id;
    final String activeUid = mainModel.currentUserDoc.id;
    final currentUserDoc = mainModel.currentUserDoc;

    final MuteUserToken muteUserToken = MuteUserToken(
        createdAt: now,
        activeUid: activeUid,
        passiveUid: passiveUid,
        tokenId: tokenId,
        tokenType: muteUserTokenTypeString);
    mainModel.muteUserTokens.add(muteUserToken);
    mainModel.muteUserIds.add(passiveUid);
    //muteしたいユーザーが作成したコンテンツを除外する
    docs.removeWhere((element) => element.data()!["uid"] == passiveUid);
    notifyListeners();
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteUserToken.toJson());
    //muteされた時の印
    final passiveUserRef = passiveUserDoc.reference;
    final UserMute userMute = UserMute(
        activeUid: activeUid,
        passiveUid: passiveUid,
        createdAt: now,
        passiveUserRef: passiveUserRef);
    await passiveUserDoc.reference
        .collection("userMutes")
        .doc(activeUid)
        .set(userMute.toJson());
  }
}
