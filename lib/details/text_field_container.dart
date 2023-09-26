import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {super.key,
      required this.color,
      // required this.borderColor,
      required this.child});

  final Color color;
  // final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        width: width * 0.9,
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
