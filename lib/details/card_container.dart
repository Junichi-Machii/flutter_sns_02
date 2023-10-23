import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/models/mute_user_model.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
    required this.borderColor,
    required this.onTap,
  });

  final Widget? child;
  final Color borderColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: child,
          ),
        ));
  }
}
