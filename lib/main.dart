import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sns_u_02/models/mute_user_model.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_sns_u_02/constants/themes.dart';
import 'package:flutter_sns_u_02/details/sns_drawer.dart';
import 'package:flutter_sns_u_02/models/create_post_modesl.dart';
import 'package:flutter_sns_u_02/models/themes_model.dart';
import 'firebase_options.dart';

import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/bottom_navigation_bar.dart';
import 'package:flutter_sns_u_02/views/login_page.dart';
import 'package:flutter_sns_u_02/models/bottom_navigation_bar_model.dart';
import 'package:flutter_sns_u_02/models/main_model.dart';

//bottomBar screens
import 'package:flutter_sns_u_02/views/main/home_screen.dart';
import 'package:flutter_sns_u_02/views/main/search_screen.dart';
import 'package:flutter_sns_u_02/views/main/profile_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User? onceUser = FirebaseAuth.instance.currentUser;
    final ThemeModel themeModel = ref.watch(themeProvider);
    return Sizer(builder: (context, orientation, deviceType) {
      return Listener(
        onPointerUp: (_) {
          if (Platform.isIOS) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeModel.isDarkTheme
              ? darkThemeData(context: context)
              : lightThemeData(context: context),
          home: onceUser == null
              ? LogInPage()
              : MyHomePage(
                  title: 'Flutter Demo Home Page',
                  themeModel: themeModel,
                ),
        ),
      );
    });
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.themeModel,
  });
  final String title;
  final ThemeModel themeModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MuteUserModel muteUserModel = ref.watch(muteUserProvider);

    // MainModelが起動してinit()が実行される
    final MainModel mainModel = ref.watch(mainProvider);
    final SNSBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);
    final CreatePostModel createPostModel = ref.watch(createPostProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.new_label),
        onPressed: () {
          return createPostModel.showPostDialog(
              context: context, mainModel: mainModel);
        },
      ),
      drawer: SNSDrawer(
        themeModel: themeModel,
        mainModel: mainModel,
      ),
      body: mainModel.isLoading
          ? const Center(
              child: Text(loadingText),
            )
          : PageView(
              controller: snsBottomNavigationBarModel.pageController,
              onPageChanged: (index) =>
                  snsBottomNavigationBarModel.onPageChanged(index: index),
              children: [
                HomeScreen(
                  mainModel: mainModel,
                  muteUserModel: muteUserModel,
                ),
                SearchScreen(),
                ProfileScreen(
                  mainModel: mainModel,
                ),
              ],
            ),
      bottomNavigationBar: SNSBottomNavigationBar(
          snsBottomNavigationBarModel: snsBottomNavigationBarModel),
    );
  }
}
