import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer(
      {super.key, required this.child, required this.borderColor});

  final Widget? child;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: child,
        ));
  }
}
