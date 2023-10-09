import 'package:flutter/material.dart';

import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/models/main/home_model.dart';

class ReloadScreen extends StatelessWidget {
  const ReloadScreen({
    super.key,
    required this.homeModel,
  });

  final HomeModel homeModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RoundedButton(
            onPressed: () async => homeModel.onReload(),
            color: Theme.of(context).colorScheme.inversePrimary,
            text: "Reload",
            widthRate: 0.85,
          ),
        )
      ],
    );
  }
}
