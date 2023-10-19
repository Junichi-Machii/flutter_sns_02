import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
import 'package:flutter_sns_u_02/constants/others.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/mute_user_token/mute_user_token.dart';

final muteUserProvider = ChangeNotifierProvider((ref) => MuteUserModel());

class MuteUserModel extends ChangeNotifier {
  Future<void> muteUser(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
      required String passiveUid}) async {
    final tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = currentUserDoc.id;

    final MuteUserToken muteUserToken = MuteUserToken(
        createdAt: now,
        activeUid: activeUid,
        passiveUid: passiveUid,
        tokenId: tokenId,
        tokenType: muteUserTokenTypeString);
    await currentUserDocToTokenDocRef(
            currentUserDoc: currentUserDoc, tokenId: tokenId)
        .set(muteUserToken.toJson());
  }
}
