import 'package:flutter/material.dart';
//package
// import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/lists.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_sns_u_02/constants/others.dart';
import 'package:flutter_sns_u_02/constants/voids.dart' as voids;

final homeProvider = ChangeNotifierProvider((ref) => HomeModel());

class HomeModel extends ChangeNotifier {
  bool isLoading = false;
  List<DocumentSnapshot<Map<String, dynamic>>> postDocs = [];
  List<String> muteUserIds = [];

  final RefreshController refreshController = RefreshController();
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
    muteUserIds = await returnMuteUids();
    await onReload();
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
    refreshController.refreshCompleted();
    await voids.processNewDocs(
        muteUserIds: muteUserIds, docs: postDocs, query: returnQuery());
    notifyListeners();
  }

  Future<void> onReload() async {
    await voids.processBasicDocs(
        muteUserIds: muteUserIds, docs: postDocs, query: returnQuery());
    notifyListeners();
  }

  Future<void> onLoading() async {
    refreshController.loadComplete();
    await voids.processOldDocs(
        muteUserIds: muteUserIds, docs: postDocs, query: returnQuery());
    notifyListeners();
  }
}
