// package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sns_u_02/constants/strings.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile> returnXFile() async {
  final ImagePicker picker = ImagePicker();
// Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
  // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  return image!;
}

Future<CroppedFile?> returnCroppedFile({required XFile? xFile}) async {
  final instance = ImageCropper();
  final CroppedFile? result = await instance.cropImage(
    sourcePath: xFile!.path,
    aspectRatioPresets: [CropAspectRatioPreset.square],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: corpperTitle,
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false),
      IOSUiSettings(
        title: corpperTitle,
      ),
    ],
  );
  return result;
}

User? returnAuthUser() => FirebaseAuth.instance.currentUser;

DocumentReference<Map<String, dynamic>> currentUserDocToTokenDocRef(
        {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc,
        required String tokenId}) =>
    currentUserDoc.reference.collection("token").doc();
