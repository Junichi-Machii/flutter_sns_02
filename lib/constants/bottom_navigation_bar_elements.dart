import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

final List<BottomNavigationBarItem> bottomNavigationBarElements = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: homeText,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.search),
    label: searchText,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: profileText,
  ),
];
