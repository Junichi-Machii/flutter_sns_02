import 'package:flutter/material.dart';

import 'package:flutter_sns_u_02/constants/strings.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider((ref) {
  return ThemeModel();
});

class ThemeModel extends ChangeNotifier {
  late SharedPreferences preferences;
  bool isDarkTheme = false;

  ThemeModel() {
    init();
  }
  Future<void> init() async {
    //端末に保存されているフラグ等を全て取得
    preferences = await SharedPreferences.getInstance();
    final x = preferences.getBool(preferencesKey);
    if (x != null) isDarkTheme = x;
    notifyListeners();
  }

  Future<void> setIsDarkTheme({required bool value}) async {
    isDarkTheme = value;
    await preferences.setBool(preferencesKey, value);
    notifyListeners();
  }
}
