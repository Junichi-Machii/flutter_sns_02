import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

import 'package:flutter_sns_u_02/models/main_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.mainModel});

  final MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            mainModel.firestoreUser.userName,
            style: TextStyle(fontSize: 40),
          ),
        )
      ],
    );
  }
}
