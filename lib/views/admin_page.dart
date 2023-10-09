import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/models/admin_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AdminModel adminModel = ref.watch(adminProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(adminPageTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedButton(
              onPressed: () async => adminModel.admin(
                  currentUserDoc: mainModel.currentUserDoc,
                  firestoreUser: mainModel.firestoreUser),
              color: Theme.of(context).colorScheme.background,
              text: 'admin',
              widthRate: 0.85,
            ),
          ),
        ],
      ),
    );
  }
}
