import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

final List<BottomNavigationBarItem> bottomNavigationBarElements = [
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.home),
    icon: Icon(Icons.home_outlined),
    label: homeText,
  ),
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.search),
    icon: Icon(Icons.search_outlined),
    label: searchText,
  ),
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.person),
    icon: Icon(Icons.person_outline),
    label: profileText,
  ),
];
