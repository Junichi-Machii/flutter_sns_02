import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/rounded_password_field.dart';
import 'package:flutter_sns_u_02/details/rounded_text_field.dart';
import 'package:flutter_sns_u_02/models/login_model.dart';
import 'package:flutter_sns_u_02/constants/routes.dart' as route;

class LogInPage extends ConsumerWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);
    final TextEditingController emailEditingController =
        TextEditingController(text: loginModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: loginModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(loginTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedTextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => loginModel.email = text,
            controller: emailEditingController,
            // borderColor: Colors.black87,
            color: Colors.white,
            prefixIcon: const Icon(Icons.email),
            hintText: hintEmailText,
          ),
          RoundedPasswordField(
            onChanged: (text) => loginModel.password = text,
            color: Colors.white,
            controller: passwordEditingController,
            obscureText: loginModel.isObscure,
            hintText: hintPasswordText,
            prefixIcon: Icon(Icons.key),
            toggleObscureText: () => loginModel.toggleIsObscure(),
          ),
          SizedBox(height: 18),
          RoundedButton(
            color: Colors.green,
            onPressed: () async => await loginModel.login(context: context),
            text: "Login",
            widthRate: 0.85,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(signInNotMemberText),
              TextButton(
                onPressed: () => route.toSignUpPage(context: context),
                child: const Text(
                  registerText,
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
