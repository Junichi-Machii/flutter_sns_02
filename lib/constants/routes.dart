import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_sns_u_02/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns_u_02/domain/post/post.dart';
import 'package:flutter_sns_u_02/main.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

import 'package:flutter_sns_u_02/views/account_page.dart';
import 'package:flutter_sns_u_02/views/admin_page.dart';
import 'package:flutter_sns_u_02/views/comments/comments_page.dart';
import 'package:flutter_sns_u_02/views/main/passive_user_profile_page.dart';
import 'package:flutter_sns_u_02/views/signup_page.dart';
import 'package:flutter_sns_u_02/views/login_page.dart';

void toSignUpPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => SignUpPage()));

void toLogInPage({required BuildContext context}) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => LogInPage()));

void toAccountPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AccountPage(
                  mainModel: mainModel,
                )));

void toMyApp({required BuildContext context}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));

void toPassiveUserProfilePage(
        {required BuildContext context,
        required FirestoreUser passiveUser,
        required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PassiveUserProfilePage(
                  passiveUser: passiveUser,
                  mainModel: mainModel,
                )));

void toAdminPage(
        {required BuildContext context, required MainModel mainModel}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdminPage(
                  mainModel: mainModel,
                )));

void toCommentsPage(
        {required BuildContext context,
        required MainModel mainModel,
        required DocumentSnapshot<Map<String, dynamic>> postDoc,
        required Post post}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentsPage(
                  mainModel: mainModel,
                  postDoc: postDoc,
                  post: post,
                )));
