import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sns_u_02/constants/themes.dart';
import 'package:flutter_sns_u_02/details/sns_drawer.dart';
import 'package:flutter_sns_u_02/models/themes_model.dart';
import 'firebase_options.dart';

import 'package:flutter_sns_u_02/constants/strings.dart';
import 'package:flutter_sns_u_02/details/bottom_navigation_bar.dart';
import 'package:flutter_sns_u_02/details/rounded_button.dart';
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
    return MaterialApp(
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
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title, required this.themeModel});

  final String title;
  final ThemeModel themeModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MainModelが起動してinit()が実行される
    final MainModel mainModel = ref.watch(mainProvider);
    final SNSBottomNavigationBarModel snsBottomNavigationBarModel =
        ref.watch(snsBottomNavigationBarProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
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
                HomeScreen(),
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
