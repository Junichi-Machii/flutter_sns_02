import 'package:flutter/material.dart';

// package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
import 'package:flutter_sns_u_02/details/rounded_password_field.dart';

//models
import 'package:flutter_sns_u_02/models/signup_model.dart';
// details
import 'package:flutter_sns_u_02/details/rounded_text_field.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpModel signUpModel = ref.watch(signUpProvider);
    final TextEditingController userNameEditingController =
        TextEditingController(text: signUpModel.userName);
    final TextEditingController emailEditingController =
        TextEditingController(text: signUpModel.email);
    final TextEditingController passwordEditingController =
        TextEditingController(text: signUpModel.password);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(signUpTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedTextField(
            color: Colors.white,
            // borderColor: Colors.black87,
            keyboardType: TextInputType.name,
            onChanged: (text) => signUpModel.userName = text,
            controller: userNameEditingController,
            prefixIcon: const Icon(Icons.person),
            hintText: hintUserNameText,
            labelText: 'user name',
          ),
          RoundedTextField(
            color: Colors.white,
            // borderColor: Colors.black87,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) => signUpModel.email = text,
            controller: emailEditingController,
            prefixIcon: const Icon(Icons.email),
            hintText: hintEmailText,
            labelText: 'email',
          ),
          RoundedPasswordField(
            onChanged: (text) => signUpModel.password = text,
            color: Colors.white,
            controller: passwordEditingController,
            hintText: hintPasswordText,
            prefixIcon: Icon(Icons.key),
            obscureText: signUpModel.isObscure,
            toggleObscureText: () => signUpModel.toggleIsObscure(),
          ),
          const SizedBox(height: 18),
          RoundedButton(
            onPressed: () async =>
                await signUpModel.createUser(context: context),
            color: Theme.of(context).colorScheme.onPrimary,
            text: signUpTitle,
            widthRate: 0.85,
          )
        ],
      ),
    );
  }
}
