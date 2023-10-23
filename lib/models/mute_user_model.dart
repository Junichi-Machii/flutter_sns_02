import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
    required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required MainModel mainModel,
    required String passiveUid,
  }) async {
    final tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final String activeUid = mainModel.currentUserDoc.id;
    final currentUserDoc = mainModel.currentUserDoc;
    final passiveUserDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveUid)
        .get();
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
    await passiveUserRef
        .collection("userMutes")
        .doc(activeUid)
        .set(userMute.toJson());
  }

// cupertinoAlertDialog

  void showAlertDialog(
      {required List<DocumentSnapshot<Map<String, dynamic>>> docs,
      required MainModel mainModel,
      required String passiveUid,
      required BuildContext context}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext innerContext) => CupertinoAlertDialog(
        title: const Text('Users Mute'),
        content: const Text('Is it really a good idea to mute users?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(innerContext);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(innerContext);
              await muteUser(
                  passiveUid: passiveUid, docs: docs, mainModel: mainModel);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  //CupertinoActionShieet
  void showPopUp(
      {required List<DocumentSnapshot<Map<String, dynamic>>> docs,
      required MainModel mainModel,
      required String passiveUid,
      required BuildContext context}) {
    showCupertinoModalPopup(
      context: context,
      // 中でcontextのinnerContextを生成する
      builder: (BuildContext innerContext) => CupertinoActionSheet(
        title: const Text('Select operation'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(innerContext);
              showAlertDialog(
                  passiveUid: passiveUid,
                  docs: docs,
                  mainModel: mainModel,
                  context: context);
            },
            child: const Text('Mute a user'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(innerContext);
            },
            child: const Text('Return'),
          ),
        ],
      ),
    );
  }
}
