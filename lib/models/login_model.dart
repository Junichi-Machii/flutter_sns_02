import 'package:flutter/material.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/models/main_model.dart';

final loginProvider = ChangeNotifierProvider((ref) => LoginModel());

class LoginModel extends ChangeNotifier {
  //auth
  String email = '';
  String password = '';
  bool isObscure = true;

  Future<void> login({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      routes.toMyApp(context: context);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void toggleIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
