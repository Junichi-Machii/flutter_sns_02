import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';

// packages
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//constants
import 'package:flutter_sns_u_02/constants/routes.dart' as routes;

final mainProvider = ChangeNotifierProvider((ref) => MainModel());

class MainModel extends ChangeNotifier {
  bool isLoading = false;

  int counter = 0;

  User? currentUser = null;
  late DocumentSnapshot<Map<String, dynamic>> currentUserDoc;

  late FirestoreUser firestoreUser;

  //tokens
  List<String> followingUids = [];

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

  Future<void> logout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    routes.toLogInPage(context: context);
    notifyListeners();
  }
}
