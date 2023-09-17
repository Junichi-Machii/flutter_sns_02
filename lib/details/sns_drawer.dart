import 'package:flutter/material.dart';

import 'package:flutter_sns_u_02/constants/routes.dart' as routes;
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

class SNSDrawer extends StatelessWidget {
  const SNSDrawer({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(drawerAccountTitle),
            onTap: () =>
                routes.toAccountPage(context: context, mainModel: mainModel),
          )
        ],
      ),
    );
  }
}
