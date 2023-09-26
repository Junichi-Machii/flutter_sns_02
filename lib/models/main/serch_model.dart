import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// package

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';

final searchProvider = ChangeNotifierProvider((ref) => SearchModel());

class SearchModel extends ChangeNotifier {
  List<FirestoreUser> users = [];

  SearchModel() {
    init();
  }

  Future<void> init() async {
    final QuerySnapshot<Map<String, dynamic>> qshot =
        await FirebaseFirestore.instance.collection("users").get();
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    users = docs.map((e) => FirestoreUser.fromJson(e.data()!)).toList();
    notifyListeners();
  }
}
