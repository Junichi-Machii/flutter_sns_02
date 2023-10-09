import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';
import 'package:flutter_sns_u_02/models/themes_model.dart';

class SNSDrawer extends StatelessWidget {
  const SNSDrawer(
      {super.key, required this.mainModel, required this.themeModel});

  final MainModel mainModel;
  final ThemeModel themeModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(drawerAccountTitle),
            onTap: () =>
                routes.toAccountPage(context: context, mainModel: mainModel),
          ),
          ListTile(
            title: const Text(drawerThemeText),
            trailing: CupertinoSwitch(
              value: themeModel.isDarkTheme,
              onChanged: (value) => themeModel.setIsDarkTheme(value: value),
            ),
          ),
          if (mainModel.firestoreUser.isAdmin)
            ListTile(
              title: const Text(adminPageTitle),
              onTap: () =>
                  routes.toAdminPage(context: context, mainModel: mainModel),
            ),
        ],
      ),
    );
  }
}
