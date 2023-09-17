import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(drawerAccountTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(logOut),
            onTap: () async => await mainModel.logout(context: context),
          )
        ],
      ),
    );
  }
}
