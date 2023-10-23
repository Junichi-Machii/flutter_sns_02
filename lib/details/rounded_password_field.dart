import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/details/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    super.key,
    required this.onChanged,
    required this.color,
    required this.controller,
    required this.obscureText,
    required this.toggleObscureText,
    required this.hintText,
    required this.prefixIcon,
  });

  final void Function(String)? onChanged;
  final Color color;
  final TextEditingController? controller;
  final bool obscureText;
  final void Function()? toggleObscureText;
  final String hintText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      widthRate: 0.85,
      color: color,
      child: TextFormField(
        style: TextStyle(color: Colors.black87),
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.visiblePassword,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          // isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          prefixIcon: prefixIcon,
          border: InputBorder.none,
          suffix: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              child: obscureText
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.black54,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Colors.black54,
                    ),
              onTap: toggleObscureText,
            ),
          ),
        ),
      ),
    );
  }
}
