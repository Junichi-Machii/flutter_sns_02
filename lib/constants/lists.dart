import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sns_u_02/constants/enums.dart';
import 'package:flutter_sns_u_02/constants/others.dart';
import 'package:flutter_sns_u_02/domain/mute_user_token/mute_user_token.dart';

Future<List<String>> returnMuteUids() async {
  final User? user = returnAuthUser();
  final tokensQshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("tokens")
      .get();
  final tokenDocs = tokensQshot.docs;

  // わかりにくい
  // List<String> muteUids = tokenDocs
  //     .where((element) => element["tokenType"] == muteUserTokenTypeString)
  //     .map((e) => MuteUserToken.fromJson(e.data()).passiveUid)
  //     .toList();

  //わかりやすく
  final List<String> muteUserIds = [];
  for (final tokenDoc in tokenDocs) {
    if (tokenDoc["tokenType"] == muteUserTokenTypeString) {
      final MuteUserToken muteUserToken =
          MuteUserToken.fromJson(tokenDoc.data());
      muteUserIds.add(muteUserToken.passiveUid);
    }
  }
  return muteUserIds;
}
