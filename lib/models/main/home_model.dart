import 'package:flutter/material.dart';
//package
// import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/others.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeModel());

class HomeModel extends ChangeNotifier {
  bool isLoading = false;
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  late User? currentUser;
  Query<Map<String, dynamic>> returnQuery() {
    final User? currentUser = returnAuthUser();

    return FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .collection("posts")
        .orderBy("createdAt", descending: true)
        .limit(30);
  }

  // final RefreshController refreshController = RefreshController();
  HomeModel() {
    init();
  }

  Future<void> init() async {
    startLoading();
    final query = returnQuery();
    final qshot = await query.get();
    postDocs = qshot.docs;
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

  Future<void> onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    await Future<void>.delayed(const Duration(seconds: 3));
    // if failed,use refreshFailed()
    // refreshController.refreshCompleted();
    if (postDocs.isNotEmpty) {
      final qshot = await returnQuery().endBeforeDocument(postDocs.first).get();
      final reversed = qshot.docs.reversed.toList();
      for (final postDoc in reversed) {
        postDocs.insert(0, postDoc);
      }
    }
    notifyListeners();
  }

  Future<void> onReload() async {
    startLoading();
    final qshot = await returnQuery().get();
    postDocs = qshot.docs;

    endLoading();
  }

  Future<void> onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    // refreshController.loadComplete();
    if (postDocs.isNotEmpty) {
      final qshot = await returnQuery().startAfterDocument(postDocs.last).get();
      for (final postDoc in qshot.docs) {
        postDocs.add(postDoc);
      }
    }
    notifyListeners();
  }
}
