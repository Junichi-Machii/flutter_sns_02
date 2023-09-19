import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

// packages
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//domain
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';

final signUpProvider = ChangeNotifierProvider((ref) => SignUpModel());

class SignUpModel extends ChangeNotifier {
  int counter = 0;

  User? currentUser = null;

  //auth
  String email = '';
  String password = '';
  bool isObscure = true;

  Future<void> createFirestoreUser({
    required BuildContext context,
    required String uid,
  }) async {
    counter++;
    var uuid = Uuid();
    final dynamic now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      email: email,
      updatedAt: now,
      uid: uid,
      userImageURL: 'userImageURL',
      userName: 'new user',
    );
    final Map<String, dynamic> userData = firestoreUser.toJson();

    await FirebaseFirestore.instance
        .collection(usersFieldKey)
        .doc(uid)
        .set(userData);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(showSnackBarAddUserText)));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    // firebaseAuth
    try {
      UserCredential resule = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = resule.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context, uid: uid);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }
}
