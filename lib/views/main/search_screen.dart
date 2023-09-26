import 'package:flutter/material.dart';

// package

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/models/main/serch_model.dart';
import 'package:flutter_sns_u_02/constants/routes.dart' as route;
import 'package:flutter_sns_u_02/models/main_model.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchModel searchModel = ref.watch(searchProvider);
    return ListView.builder(
        itemCount: searchModel.users.length,
        itemBuilder: (context, index) {
          final FirestoreUser firestoreUser = searchModel.users[index];
          return ListTile(
            title: Text(firestoreUser.uid),
            onTap: () => route.toPassiveUserProfilePage(
                passiveUser: firestoreUser,
                context: context,
                mainModel: MainModel()),
          );
        });
  }
}
