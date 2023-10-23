import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/domain/user_update_log/user_update_log.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

final editProfileProvider = ChangeNotifierProvider((ref) => EditProfileModel());

class EditProfileModel extends ChangeNotifier {
  File? croppedFile;
  String userName = "";
  String userImageURL = "";

  Future<void> updateUserName({
    required BuildContext context,
    required MainModel mainModel,
  }) async {
    mainModel.updateFrontUserName(newUserName: userName);
    Navigator.pop(context);
    final currentUserDoc = mainModel.currentUserDoc;
    final UserUpDateLog upDateLog = UserUpDateLog(
        updatedAt: Timestamp.now(),
        userName: userName,
        userImageURL: userImageURL);
    await currentUserDoc.reference
        .collection("userUpdateLog")
        .doc()
        .set(upDateLog.toJson());
  }
}
