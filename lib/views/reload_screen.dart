import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

import 'package:flutter_sns_u_02/details/rounded_button.dart';

class ReloadScreen extends StatelessWidget {
  const ReloadScreen({
    super.key,
    required this.onReload,
  });

  final void Function()? onReload;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: RoundedButton(
            onPressed: onReload,
            color: Theme.of(context).colorScheme.inversePrimary,
            text: reloadText,
            widthRate: 0.85,
          ),
        )
      ],
    );
  }
}
