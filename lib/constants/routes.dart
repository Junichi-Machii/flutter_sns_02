import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/main.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

//pages
import 'package:flutter_sns_u_02/views/signup_page.dart';
import 'package:flutter_sns_u_02/views/login_page.dart';

void toSignUpPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => SignUpPage()));

void toLogInPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => LogInPage()));

void toMyApp({required BuildContext context}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
