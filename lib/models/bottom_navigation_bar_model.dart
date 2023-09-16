import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
// constants
import 'package:flutter_sns_u_02/constants/ints.dart';

final snsBottomNavigationBarProvider = ChangeNotifierProvider((ref) {
  return SNSBottomNavigationBarModel();
});

class SNSBottomNavigationBarModel extends ChangeNotifier {
  int currentIndex = 0;

  late PageController pageController;

  SNSBottomNavigationBarModel() {
    init();
  }

  void init() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }

  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

  void onTabTapped({required int index}) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: pageAnimationDuration),
      curve: Curves.easeIn,
    );
  }

  void setPageController() {
    pageController = PageController(initialPage: currentIndex);
    notifyListeners();
  }
}
