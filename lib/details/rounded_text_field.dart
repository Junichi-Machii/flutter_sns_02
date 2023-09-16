import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/details/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    super.key,
    required this.keyboardType,
    required this.onChanged,
    required this.controller,
    required this.color,
    required this.hintText,
    required this.prefixIcon,
  });

  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final Color color;
  final String hintText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: color,
      child: TextField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: InputBorder.none,
        ),
        controller: controller,
      ),
    );
  }
}
