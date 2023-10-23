import 'package:cloud_firestore/cloud_firestore.dart';

bool isValidUser(
        {required List<String> muteUserIds,
        required DocumentSnapshot<Map<String, dynamic>> doc}) =>
    !muteUserIds.contains(doc["uid"]);
