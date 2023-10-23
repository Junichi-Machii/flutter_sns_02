import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {super.key,
      required this.color,
      required this.widthRate,
      required this.child});

  final Color color;
  // final Color borderColor;
  final Widget child;
  final double widthRate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final maxWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        width: maxWidth * widthRate,
        decoration: BoxDecoration(
            // border: Border.all(
            //   // color: borderColor,
            // ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface,
                blurRadius: 8.0,
              )
            ],
            color: color,
            borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
