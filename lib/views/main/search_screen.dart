import 'package:flutter/material.dart';
import 'package:flutter_sns_u_02/constants/strings.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(searchText),
    );
  }
}
