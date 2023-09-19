import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//constans
import 'package:flutter_sns_u_02/constants/others.dart';

//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final profileProvider = ChangeNotifierProvider(((ref) => ProfileModel()));

class ProfileModel extends ChangeNotifier {
  File? croppedFile;

  // Future<void> pickImage() async {
  //   xFile = await returnXFile();
  // }

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String fileName = returnJpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    //users/uid/ファイル名に　アップロード
    await storageRef.putFile(file);
    //users/uid/ファイル名　のURLを所得
    return await storageRef.getDownloadURL();
  }

  Future<void> uploadUserImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    final XFile xFile = await returnXFile();
    final File file = File(xFile.path);
    final String uid = currentUserDoc.id;
    CroppedFile? croppedFile = await returnCroppedFile(xFile: xFile);
    final String url = await uploadImageAndGetURL(
      uid: uid,
      file: file,
    );
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
    notifyListeners();
  }
}
