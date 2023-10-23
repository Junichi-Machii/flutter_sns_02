import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flash/flash_helper.dart';
import 'package:flash/flash.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

void showFlashDialog(
    {required BuildContext context,
    required MainModel mainModel,
    required TextEditingController textEditingController,
    required void Function(String)? onChanged,
    required String titleString,
    required Color? indicatorColor,
    required Color? barrierColor,
    required Widget Function(BuildContext, FlashController<String>) builder}) {
  context.showFlash<String>(
      persistent: true,
      barrierColor: barrierColor,
      barrierDismissible: true,
      builder: builder);
}

// inside of onRefresh
Future<void> processNewDocs(
    {required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required Query<Map<String, dynamic>> query}) async {
  if (docs.isNotEmpty) {
    final qshot = await query.limit(30).endBeforeDocument(docs.first).get();
    final reversed = qshot.docs.reversed.toList();
    for (final postDoc in reversed) {
      docs.insert(0, postDoc);
    }
  }
}

// inside of onReload
Future<void> processBasicDocs(
    {required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required Query<Map<String, dynamic>> query}) async {
  final qshot = await query.limit(30).get();
  for (final doc in qshot.docs) {
    docs.add(doc);
  }
}

// inside of onLoading
Future<void> processOldDocs(
    {required List<DocumentSnapshot<Map<String, dynamic>>> docs,
    required Query<Map<String, dynamic>> query}) async {
  if (docs.isNotEmpty) {
    final qshot = await query.limit(30).startAfterDocument(docs.last).get();
    for (final postDoc in qshot.docs) {
      docs.add(postDoc);
    }
  }
}
